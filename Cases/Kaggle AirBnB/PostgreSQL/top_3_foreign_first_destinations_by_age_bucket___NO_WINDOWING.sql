/* this requires the following scripts to have been run:
- AGDstats_generate_agefrom_and_ageto_from_agebucket.sql
- USERS_clean_up.sql */


-- query_1
DROP TABLE IF EXISTS query_1;

SELECT
    age_buckets.age_bucket AS age_bucket,
    users_clean.country_destination AS dest,
    COUNT(DISTINCT users_clean.id) AS nb_1st_bkgs_2014,
    age_dest_stats.nb_all_bkgs_2015 AS nb_all_bkgs_2015
  INTO
    TEMP TABLE query_1
  FROM
    users_clean
      LEFT JOIN age_buckets
        ON users_clean.age BETWEEN age_buckets.age_from AND age_buckets.age_to
          LEFT JOIN

            (SELECT
              age_bucket,
              country_destination AS dest,
              1000 * SUM(population_in_thousands) AS nb_all_bkgs_2015
            FROM
              age_gender_destination_stats
            GROUP BY
              age_bucket,
              country_destination) age_dest_stats

            ON users_clean.country_destination = age_dest_stats.dest AND
               age_buckets.age_bucket = age_dest_stats.age_bucket

  WHERE
    users_clean.country_destination NOT IN ('US', 'other', 'NDF') AND
    users_clean.fst_bkg_yr = 2014
  GROUP BY
    age_buckets.age_bucket,
    users_clean.country_destination,
    nb_all_bkgs_2015
  ORDER BY
    age_bucket,
    nb_1st_bkgs_2014 DESC,
    nb_all_bkgs_2015 DESC;

SELECT
    *
  FROM
    query_1;


-- query_1a
DROP TABLE IF EXISTS query_1a;

SELECT
    query_1.age_bucket AS age_bucket,
    query_1.dest AS dest,
    query_1.nb_1st_bkgs_2014 AS nb_1st_bkgs_2014,
    query_1.nb_1st_bkgs_2014 / query_1_sum_groupby_age_bucket.total_nb_1st_bkgs_2014
      AS prop_in_bucket_nb_bkgs,
    query_1.nb_1st_bkgs_2014 / query_1.nb_all_bkgs_2015 AS prop_in_all_bkgs
  INTO
    TEMP TABLE query_1a
  FROM

    query_1

    JOIN

    (SELECT
        age_bucket,
        SUM(nb_1st_bkgs_2014) AS total_nb_1st_bkgs_2014
      FROM
        query_1
      GROUP BY
        age_bucket) query_1_sum_groupby_age_bucket

    ON query_1.age_bucket = query_1_sum_groupby_age_bucket.age_bucket;

SELECT
    *
  FROM
    query_1a;


-- query_2
DROP TABLE IF EXISTS query_2;

SELECT
    *
  INTO
    TEMP TABLE query_2
  FROM
    query_1a
  WHERE
    (SELECT
        COUNT(*)
      FROM
        query_1a query_1a_clone
      WHERE
        query_1a_clone.age_bucket = query_1a.age_bucket AND
        query_1a_clone.nb_1st_bkgs_2014 >= query_1a.nb_1st_bkgs_2014) <= 3;

SELECT
    *
  FROM
    query_2;


-- results
SELECT
    query_2.*,
    countries.destination_language AS dest_lang,
    countries.distance_km AS dist_km,
    countries.destination_km2 AS dest_area_km2
  FROM

    query_2
      LEFT JOIN countries
        ON query_2.dest = countries.country_destination

  ORDER BY
    age_bucket,
    nb_1st_bkgs_2014 DESC;

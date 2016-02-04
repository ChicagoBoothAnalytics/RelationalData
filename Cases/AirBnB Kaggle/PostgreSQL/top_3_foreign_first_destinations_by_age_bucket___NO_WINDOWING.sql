/* this requires the following scripts to have been run:
- AGDstats_generate_agefrom_and_ageto_from_agebucket.sql
- USERS_clean_up.sql */


-- temp_table_1
DROP TABLE IF EXISTS temp_table_1;

SELECT
    age_buckets.age_bucket AS age_bucket,
    users_clean.country_destination AS dest,
    COUNT(DISTINCT users_clean.id) AS nb_1st_bkgs_2014,
    age_dest_stats.nb_all_bkgs_2015 AS nb_all_bkgs_2015
  INTO
    TEMP TABLE temp_table_1
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
    temp_table_1;


-- temp_table_2
DROP TABLE IF EXISTS temp_table_2;

SELECT
    temp_table_1.age_bucket AS age_bucket,

    (SELECT
        COUNT(*) + 1
      FROM
        temp_table_1 temp_table_1a_clone
      WHERE
        temp_table_1a_clone.age_bucket = temp_table_1.age_bucket AND
        temp_table_1a_clone.nb_1st_bkgs_2014 > temp_table_1.nb_1st_bkgs_2014) AS dest_rank,

    temp_table_1.dest AS dest,
    temp_table_1.nb_1st_bkgs_2014 AS nb_1st_bkgs_2014,
    temp_table_1.nb_1st_bkgs_2014 / temp_table_1_sum_groupby_age_bucket.total_nb_1st_bkgs_2014
      AS prop_in_bucket_nb_bkgs,
    temp_table_1.nb_1st_bkgs_2014 / temp_table_1.nb_all_bkgs_2015 AS prop_in_all_bkgs
  INTO
    TEMP TABLE temp_table_2
  FROM

    temp_table_1

    JOIN

    (SELECT
        age_bucket,
        SUM(nb_1st_bkgs_2014) AS total_nb_1st_bkgs_2014
      FROM
        temp_table_1
      GROUP BY
        age_bucket) temp_table_1_sum_groupby_age_bucket

    ON temp_table_1.age_bucket = temp_table_1_sum_groupby_age_bucket.age_bucket;

SELECT
    *
  FROM
    temp_table_2;


-- results
SELECT
    temp_table_2.*,
    countries.destination_language AS dest_lang,
    countries.distance_km AS dist_km,
    countries.destination_km2 AS dest_area_km2
  FROM
    temp_table_2
      LEFT JOIN countries
        ON temp_table_2.dest = countries.country_destination
  WHERE
    temp_table_2.dest_rank <= 3
  ORDER BY
    age_bucket,
    nb_1st_bkgs_2014 DESC;

/* this assumes the following scripts have been run:
- AGDstats_generate_agefrom_and_ageto_from_agebucket.sql
- USERS_clean_up.sql */

SELECT
    sub_query_2.*,
    countries.destination_language AS dest_lang,
    countries.distance_km AS dist_km,
    countries.destination_km2 AS dest_area_km2
  FROM

    (SELECT
        age_bucket,
        RANK() OVER desc_nb_1st_bkgs_by_age_bucket AS dest_rank,
        dest,
        nb_1st_bkgs_2014,
        nb_1st_bkgs_2014 / SUM(nb_1st_bkgs_2014) OVER by_age_bucket AS prop_in_bucket_nb_bkgs
      FROM

        (SELECT
            age_buckets.age_bucket AS age_bucket,
            users_clean.country_destination AS dest,
            COUNT(*) AS nb_1st_bkgs_2014
          FROM
            users_clean
              LEFT JOIN age_buckets
                ON users_clean.age BETWEEN age_buckets.age_from AND age_buckets.age_to
          WHERE
            users_clean.country_destination NOT IN ('US', 'other', 'NDF') AND
            users_clean.fst_bkg_yr = 2014
          GROUP BY
            age_buckets.age_bucket,
            users_clean.country_destination) sub_query_1

      WINDOW
        by_age_bucket AS
          (PARTITION BY age_bucket),
        desc_nb_1st_bkgs_by_age_bucket AS
          (PARTITION BY age_bucket
           ORDER BY nb_1st_bkgs_2014 DESC)) sub_query_2

    LEFT JOIN countries
      ON sub_query_2.dest = countries.country_destination

  WHERE
    sub_query_2.dest_rank <= 3
  ORDER BY
    age_bucket,
    dest_rank;

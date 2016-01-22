/* this assumes the following scripts have been run:
- AGDstats_generate_agefrom_and_ageto_from_agebucket.sql
- USERS_clean_up.sql */

SELECT
    *
  FROM

    (SELECT
        age_bucket,
        age_from,
        country_destination,
        nb_first_bookings_2014,
        RANK() OVER by_age_bucket AS nb_first_bookings_2014_rank
      FROM

        (SELECT
            users_clean_with_age_buckets.age_bucket AS age_bucket,
            age_buckets.age_from AS age_from,
            users_clean_with_age_buckets.country_destination AS country_destination,
            COUNT(*) AS nb_first_bookings_2014
          FROM
            users_clean_with_age_buckets
              LEFT JOIN age_buckets
                ON users_clean_with_age_buckets.age_bucket = age_buckets.age_bucket
          WHERE
            users_clean_with_age_buckets.age_bucket IS NOT NULL AND
            users_clean_with_age_buckets.country_destination NOT IN ('US', 'other', 'NDF') AND
            users_clean_with_age_buckets.fst_bkg_yr = 2014
          GROUP BY
            users_clean_with_age_buckets.age_bucket,
            age_buckets.age_from,
            users_clean_with_age_buckets.country_destination) sub_query_1

      WINDOW
        by_age_bucket AS
          (PARTITION BY age_bucket
           ORDER BY nb_first_bookings_2014 DESC)
      ORDER BY
        age_from) sub_query_2

  WHERE
    nb_first_bookings_2014_rank <= 3;

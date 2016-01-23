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
        RANK() OVER descending_nb_first_bookings_by_age_bucket AS nb_first_bookings_2014_rank
      FROM

        (SELECT
            age_buckets.age_bucket AS age_bucket,
            age_buckets.age_from AS age_from,
            users_clean.country_destination AS country_destination,
            COUNT(*) AS nb_first_bookings_2014
          FROM
            users_clean
              LEFT JOIN age_buckets
                ON users_clean.age BETWEEN age_buckets.age_from AND age_buckets.age_to
          WHERE
            users_clean.country_destination NOT IN ('US', 'other', 'NDF') AND
            users_clean.fst_bkg_yr = 2014
          GROUP BY
            age_buckets.age_bucket,
            age_buckets.age_from,
            users_clean.country_destination) sub_query_1

      WINDOW
        descending_nb_first_bookings_by_age_bucket AS
          (PARTITION BY age_bucket
           ORDER BY nb_first_bookings_2014 DESC)) sub_query_2

  WHERE
    nb_first_bookings_2014_rank <= 3
  ORDER BY
    age_from,
    nb_first_bookings_2014_rank;

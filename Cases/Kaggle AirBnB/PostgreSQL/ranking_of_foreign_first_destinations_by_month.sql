/* this assumes the following scripts have been run:
- USERS_clean_up.sql */

SELECT
    start_of_mth,
    dest_rank_in_mth,
    LAG(dest_rank_in_mth, 1, NULL) OVER inc_mth_by_dest - dest_rank_in_mth AS dest_rank_rise_vs_last_mth,
    dest,
    nb_1st_bkgs_in_mth
  FROM
    (SELECT
        start_of_mth,
        RANK() OVER desc_nb_1st_bkgs_by_mth AS dest_rank_in_mth,
        dest,
        nb_1st_bkgs_in_mth
      FROM
        (SELECT
            CAST(DATE_TRUNC('month', date) AS DATE) AS start_of_mth,
            dest,
            SUM(nb_1st_bkgs) AS nb_1st_bkgs_in_mth
          FROM
            (SELECT
                fst_bkg_date AS date,
                country_destination AS dest,
                COUNT(*) AS nb_1st_bkgs
              FROM
                users_clean
              WHERE
                fst_bkg_date IS NOT NULL AND
                country_destination NOT IN ('US', 'other', 'NDF')
              GROUP BY
                fst_bkg_date,
                country_destination) nb_1st_bkgs_by_date_by_dest
          GROUP BY
            DATE_TRUNC('month', date),
            dest) nb_1st_bkgs_by_mth_by_dest
      WINDOW
        desc_nb_1st_bkgs_by_mth AS
          (PARTITION BY start_of_mth
           ORDER BY nb_1st_bkgs_in_mth DESC)) sub_query
  WINDOW
    inc_mth_by_dest AS
      (PARTITION BY dest
       ORDER BY start_of_mth)
  ORDER BY
    start_of_mth,
    dest_rank_in_mth;

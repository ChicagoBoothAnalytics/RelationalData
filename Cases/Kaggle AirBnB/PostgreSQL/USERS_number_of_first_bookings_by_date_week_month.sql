/* this assumes the following scripts have been run:
- USERS_clean_up.sql */


-- number of first bookings by Date
DROP TABLE IF EXISTS nb_1st_bkgs_by_date;

SELECT
    fst_bkg_date AS date,
    COUNT(*) AS nb_1st_bkgs
  INTO TEMP TABLE
    nb_1st_bkgs_by_date
  FROM
    users_clean
  WHERE
    fst_bkg_date IS NOT NULL
  GROUP BY
    fst_bkg_date
  ORDER BY
    date;

SELECT
    *
  FROM
    nb_1st_bkgs_by_date;


-- number of first bookings by Week
DROP TABLE IF EXISTS nb_1st_bkgs_by_wk;

SELECT
    sunday_end_of_wk,
    SUM(nb_1st_bkgs) AS nb_1st_bkgs_in_wk
  INTO TEMP TABLE
    nb_1st_bkgs_by_wk
  FROM
    (SELECT
        CASE WHEN CAST(EXTRACT(DoW FROM date) AS INT) % 7 > 0
               THEN date + 7 - CAST(EXTRACT(DoW FROM date) AS INT) % 7
             ELSE date
             END
          AS sunday_end_of_wk,
        nb_1st_bkgs
      FROM
        nb_1st_bkgs_by_date) sub_query
  GROUP BY
    sunday_end_of_wk
  ORDER BY
    sunday_end_of_wk;

SELECT
    *
  FROM
    nb_1st_bkgs_by_wk;


-- number of first bookings by Month
DROP TABLE IF EXISTS nb_1st_bkgs_by_mth;

SELECT
    start_of_month,
    SUM(nb_1st_bkgs) AS nb_1st_bkgs_in_mth
  INTO TEMP TABLE
    nb_1st_bkgs_by_mth
  FROM
    (SELECT
        CAST(DATE_TRUNC('month', date) AS DATE) AS start_of_month,
        nb_1st_bkgs
      FROM
        nb_1st_bkgs_by_date) sub_query
  GROUP BY
    start_of_month
  ORDER BY
    start_of_month;

SELECT
    *
  FROM
    nb_1st_bkgs_by_mth;

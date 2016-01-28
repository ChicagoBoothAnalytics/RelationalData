/* this assumes the following scripts have been run:
- USERS_clean_up.sql */


-- calculate the number of foreign first bookings by Month & by Destination
DROP TABLE IF EXISTS nb_1st_bkgs_by_mth_by_dest;

SELECT
    CAST(DATE_TRUNC('month', date) AS DATE) AS start_of_mth,
    dest,
    SUM(nb_1st_bkgs) AS nb_1st_bkgs_in_mth
  INTO
    TEMP TABLE nb_1st_bkgs_by_mth_by_dest
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
    dest
  ORDER BY
    start_of_mth,
    dest;

SELECT
    *
  FROM
    nb_1st_bkgs_by_mth_by_dest;


-- augment the above table with zeros for Destinations with no first bookings in a Month
DROP TABLE IF EXISTS nb_1st_bkgs_incl_zeros_by_mth_by_dest;

SELECT
    all_mths_and_foreign_dests.start_of_mth AS start_of_mth,
    all_mths_and_foreign_dests.dest AS dest,
    COALESCE(nb_1st_bkgs_by_mth_by_dest.nb_1st_bkgs_in_mth, 0) AS nb_1st_bkgs_in_mth
  INTO
    TEMP TABLE nb_1st_bkgs_incl_zeros_by_mth_by_dest
  FROM
    nb_1st_bkgs_by_mth_by_dest

    RIGHT JOIN

    (SELECT
        all_mths.start_of_mth AS start_of_mth,
        foreign_dests.column1 AS dest
      FROM

        (SELECT
            DISTINCT start_of_mth
          FROM
            nb_1st_bkgs_by_mth_by_dest) all_mths

        CROSS JOIN

        (VALUES ('AU'), ('CA'), ('DE'), ('ES'), ('FR'),
                ('GB'), ('IT'), ('NL'), ('PT')) foreign_dests) all_mths_and_foreign_dests

        ON nb_1st_bkgs_by_mth_by_dest.start_of_mth = all_mths_and_foreign_dests.start_of_mth AND
           nb_1st_bkgs_by_mth_by_dest.dest = all_mths_and_foreign_dests.dest
  ORDER BY
    start_of_mth,
    dest;

SELECT
    *
  FROM
    nb_1st_bkgs_incl_zeros_by_mth_by_dest;


-- compute rankings among Destinations by Month WITHOUT use of windowing:

-- temp_table
DROP TABLE IF EXISTS temp_table;

SELECT

    (SELECT
        COUNT(*) + 1
      FROM
        nb_1st_bkgs_incl_zeros_by_mth_by_dest clone
      WHERE
        clone.dest = nb_1st_bkgs_incl_zeros_by_mth_by_dest.dest AND
        clone.start_of_mth < nb_1st_bkgs_incl_zeros_by_mth_by_dest.start_of_mth)
      AS mth_order,

    nb_1st_bkgs_incl_zeros_by_mth_by_dest.start_of_mth AS start_of_mth,

    (SELECT
        COUNT(*) + 1
      FROM
        nb_1st_bkgs_incl_zeros_by_mth_by_dest clone
      WHERE
        clone.start_of_mth = nb_1st_bkgs_incl_zeros_by_mth_by_dest.start_of_mth AND
        clone.nb_1st_bkgs_in_mth > nb_1st_bkgs_incl_zeros_by_mth_by_dest.nb_1st_bkgs_in_mth)
      AS dest_rank_in_mth,

    nb_1st_bkgs_incl_zeros_by_mth_by_dest.dest AS dest,
    nb_1st_bkgs_incl_zeros_by_mth_by_dest.nb_1st_bkgs_in_mth AS nb_1st_bkgs_in_mth
  INTO
    TEMP TABLE temp_table
  FROM
    nb_1st_bkgs_incl_zeros_by_mth_by_dest;

SELECT
    *
  FROM
    temp_table;


-- results
SELECT
    temp_table.start_of_mth AS start_of_mth,
    temp_table.dest_rank_in_mth AS dest_rank_in_mth,
    temp_table_clone.dest_rank_in_mth - temp_table.dest_rank_in_mth
      AS dest_rank_rise_vs_last_mth,
    temp_table.dest AS dest,
    temp_table.nb_1st_bkgs_in_mth AS nb_1st_bkgs_in_mth
  FROM
    temp_table
      LEFT JOIN temp_table temp_table_clone
        ON temp_table.dest = temp_table_clone.dest AND
           temp_table.mth_order = temp_table_clone.mth_order + 1
  ORDER BY
    start_of_mth,
    dest_rank_in_mth;

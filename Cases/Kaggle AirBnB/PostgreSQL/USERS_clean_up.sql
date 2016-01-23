DROP TABLE IF EXISTS users_clean_temp;

SELECT
    id,
    date_account_created AS acct_crt_date,
    EXTRACT(YEAR FROM date_account_created) AS acct_crt_yr,
    EXTRACT(MONTH FROM date_account_created) AS acct_crt_mth,
    EXTRACT(DAY FROM date_account_created) AS acct_crt_day,
    EXTRACT(DoW FROM date_account_created) AS acct_crt_day_of_wk_idx,
    CASE WHEN date_account_created IS NULL THEN NULL
         ELSE CONCAT(EXTRACT(DoW FROM date_account_created), ': ',
                     TO_CHAR(date_account_created, 'Dy'))
         END
         AS acct_crt_day_of_wk,
    CAST(
        CONCAT(
            SUBSTR(timestamp_first_active, 1, 4),
            '-',
            SUBSTR(timestamp_first_active, 5, 2),
            '-',
            SUBSTR(timestamp_first_active, 7, 2),
            ' ',
            SUBSTR(timestamp_first_active, 9, 2),
            ':',
            SUBSTR(timestamp_first_active, 11, 2),
            ':',
            SUBSTR(timestamp_first_active, 13, 2))
        AS TIMESTAMP)
      AS fst_actv_ts,
    date_first_booking AS fst_bkg_date,
    EXTRACT(YEAR FROM date_first_booking) AS fst_bkg_yr,
    EXTRACT(MONTH FROM date_first_booking) AS fst_bkg_mth,
    EXTRACT(DAY FROM date_first_booking) AS fst_bkg_day,
    EXTRACT(DoW FROM date_first_booking) AS fst_bkg_day_of_wk_idx,
    CASE WHEN date_first_booking IS NULL THEN NULL
         ELSE CONCAT(EXTRACT(DoW FROM date_first_booking), ': ',
                     TO_CHAR(date_first_booking, 'Dy'))
         END
         AS fst_bkg_day_of_wk,
    CASE WHEN age > 1000 THEN 2015 - age
         ELSE age
         END
         AS age,
    CASE WHEN gender = '-unknown-' THEN NULL
         ELSE gender
         END
         AS gender,
    language,
    signup_method,
    signup_flow,
    signup_app,
    first_device_type,
    CASE WHEN first_browser = '-unknown-' THEN NULL
         ELSE first_browser
         END
         AS first_browser,
    affiliate_channel,
    affiliate_provider,
    CASE WHEN first_affiliate_tracked = 'null' THEN NULL
         ELSE first_affiliate_tracked
         END
         AS first_affiliate_tracked,
    country_destination
  INTO
    TEMP TABLE users_clean_temp
  FROM
    users;


DROP TABLE IF EXISTS users_clean;

SELECT
    id,
    acct_crt_date,
    acct_crt_yr,
    acct_crt_mth,
    acct_crt_day,
    acct_crt_day_of_wk_idx,
    acct_crt_day_of_wk,
    fst_actv_ts,
    EXTRACT(YEAR FROM fst_actv_ts) AS fst_actv_yr,
    EXTRACT(MONTH FROM fst_actv_ts) AS fst_actv_mth,
    EXTRACT(DAY FROM fst_actv_ts) AS fst_actv_day,
    EXTRACT(DoW FROM fst_actv_ts) AS fst_actv_day_of_wk_idx,
    CASE WHEN fst_actv_ts IS NULL THEN NULL
         ELSE CONCAT(EXTRACT(DoW FROM fst_actv_ts), ': ',
                     TO_CHAR(fst_actv_ts, 'Dy'))
         END
         AS fst_actv_day_of_wk,
    EXTRACT(HOUR FROM fst_actv_ts) AS fst_actv_hr,
    fst_bkg_date,
    fst_bkg_yr,
    fst_bkg_mth,
    fst_bkg_day,
    fst_bkg_day_of_wk_idx,
    fst_bkg_day_of_wk,
    CASE WHEN age BETWEEN 18.0 AND 100.0 THEN age
         ELSE NULL
         END
         AS age,
    gender,
    language,
    signup_method,
    signup_flow,
    signup_app,
    first_device_type,
    first_browser,
    affiliate_channel,
    affiliate_provider,
    first_affiliate_tracked,
    country_destination
  INTO
    TEMP TABLE users_clean
  FROM
    users_clean_temp;


DROP TABLE IF EXISTS users_clean_temp;

SELECT
    *
  FROM
    users_clean;

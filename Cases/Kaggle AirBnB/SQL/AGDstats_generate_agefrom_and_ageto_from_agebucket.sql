-- generate "age_from" & "age_to" from "age_bucket"

DROP TABLE IF EXISTS age_gender_destination_stats_with_age_from_to;

SELECT
    age_bucket,
    CAST(age_from_to[1] AS DOUBLE PRECISION) - 0.5 AS age_from,
    CAST(age_from_to[2] AS DOUBLE PRECISION) + 0.5 AS age_to,
    gender,
    country_destination,
    population_in_thousands
  INTO
    TEMP TABLE age_gender_destination_stats_with_age_from_to
  FROM
    (SELECT
        age_bucket,
        CASE WHEN age_bucket = '100+' THEN ARRAY['100', '100']
             ELSE REGEXP_MATCHES(age_bucket, '([0-9]*)-([0-9]*)')
                  -- alternatives in this case:
                  -- REGEXP_SPLIT(age_bucket, '-') or
                  -- STRING_TO_ARRAY(age_bucket, '-')
             END
             AS age_from_to,
        gender,
        country_destination,
        population_in_thousands
      FROM
        age_gender_destination_stats) sub_query
  ORDER BY
    age_from,
    gender,
    country_destination;

SELECT
    *
  FROM
      age_gender_destination_stats_with_age_from_to;


-- obtain definitions of distinct age buckets

DROP TABLE IF EXISTS age_buckets;

SELECT
    DISTINCT
      age_bucket,
      age_from,
      age_to
  INTO
    TEMP TABLE age_buckets
  FROM
    age_gender_destination_stats_with_age_from_to
  ORDER BY
    age_from;

SELECT
    *
  FROM
    age_buckets;

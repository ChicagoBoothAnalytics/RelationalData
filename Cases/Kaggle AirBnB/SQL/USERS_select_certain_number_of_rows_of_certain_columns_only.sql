SELECT   -- list of specific columns
    id,
    age,
    gender,
    language,
    country_destination
  FROM
    users
  LIMIT
    30   -- limit result to N rows only
  ;

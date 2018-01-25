input_data = LOAD 'input/klickstream_Data' USING PigStorage(',') AS (userid: int, PLZ: int, adid: int, has-clicked-on-ad: Boolean)

-- Output as Total Klicks :
clicked_ads = FILTER input_data BY has-clicked-on-ad == true;
grouped_ads = GROUP clicked_ads BY adid;
total_clicks = FOREACH grouped_ads GENERATE group AS (adid), COUNT(adid) AS count;
dumb total_clicks


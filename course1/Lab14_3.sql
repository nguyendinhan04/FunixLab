use vertabelo;

select count(*) from unindexed_samples;

SELECT max(wind_mtsperhour) FROM unindexed_samples;
create index m_index  on unindexed_samples(wind_mtsperhour) using btree; 
SELECT max(wind_mtsperhour) FROM unindexed_samples;
-- The runing time decrease from 1.844s to 0.000s

SELECT * FROM unindexed_samples where temperature_dht11 = 12 AND humidity_dht11 = 37;
-- the query take 2.031s

 SELECT max(temperature_dht11) FROM unindexed_samples;	
--  the query take 1/766s


SELECT max(humidity_dht11) FROM unindexed_samples;
-- the query take 1.734s

create index th_index on unindexed_samples(temperature_dht11,humidity_dht11);

SELECT * FROM unindexed_samples where temperature_dht11 = 12 AND humidity_dht11 = 37;
-- After create index time taken is 0.000s

SELECT max(temperature_dht11) FROM unindexed_samples;
-- After create index time taken is 0.000s

SELECT max(humidity_dht11) FROM unindexed_samples;
-- After create index time taken is 1.343s

SHOW INDEX FROM unindexed_samples;
DROP INDEX m_index ON tbl_name;

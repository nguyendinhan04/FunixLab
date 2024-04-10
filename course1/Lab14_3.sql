use vertabelo;

select count(*) from unindexed_samples;

SELECT max(wind_mtsperhour) FROM unindexed_samples;
create index m_index  on unindexed_samples(wind_mtsperhour) using btree; 


SELECT * FROM unindexed_samples where temperature_dht11 = 12 AND humidity_dht11 = 37;

 SELECT max(temperature_dht11) FROM unindexed_samples;	


SELECT max(humidity_dht11) FROM unindexed_samples;

create index th_index on unindexed_samples(temperature_dht11,humidity_dht11);

SHOW INDEX FROM unindexed_samples;



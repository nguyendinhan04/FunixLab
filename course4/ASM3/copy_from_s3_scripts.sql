copy asm3_cs4_dbo.dim_country (country_id,country)
from 's3://mybucket210/DIM_COUNTRY.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;


copy asm3_cs4_dbo.dim_date (date_id,date_added, release_year)
from 's3://mybucket210/DIM_DATE.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;


copy asm3_cs4_dbo.dim_director (director_id,director)
from 's3://mybucket210/DIM_DIRECTOR.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;

copy asm3_cs4_dbo.dim_duration (duration_id,duration)
from 's3://mybucket210/DIM_DURATION.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
    CSV;



copy asm3_cs4_dbo.dim_info (info_id,tilte,listed_in, description,"cast")
from 's3://mybucket210/DIM_INFO.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;


copy asm3_cs4_dbo.dim_rating (rating_id,rating)
from 's3://mybucket210/DIM_RATING.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;



copy asm3_cs4_dbo.dim_type (type_id,type)
from 's3://mybucket210/DIM_TYPE.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;



copy asm3_cs4_dbo.fact_netflix_shows (show_id,info_id, type_id,director_id,country_id, date_id,rating_id, duration_id)
from 's3://mybucket210/FACT_NETFLIX_SHOWS.csv'
credentials 'aws_access_key_id=KEY;aws_secret_access_key=SECRETE_KEY'
CSV;

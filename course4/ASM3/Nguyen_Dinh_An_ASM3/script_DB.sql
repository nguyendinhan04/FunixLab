drop table DIM_COUNTRY;
create table DIM_COUNTRY(
    country_id int primary key identity(1,1),
    country VARCHAR(255)
);

drop table DIM_DIRECTOR;
create table DIM_DIRECTOR(
    director_id int primary key identity(1,1),
    director varchar(255)
);


drop table DIM_TYPE;
create table DIM_TYPE(
    type_id int primary key identity(1,1),
    type varchar(255)
);

drop table DIM_DATE;
create table DIM_DATE(
    date_id int primary key identity(1,1),
    date_added varchar(255),
    release_year varchar(255)
);

drop table DIM_RATING;
create table DIM_RATING(
    rating_id int primary key identity(1,1),
    rating varchar(255)
);

drop table DIM_INFO;
create table DIM_INFO(
    info_id int primary key identity(1,1),
    tilte varchar(255),
    listed_in varchar(255),
    description varchar(1000),
    cast varchar(2000)
);


drop table DIM_DURATION;
create table DIM_DURATION(
    duration_id int primary key identity(1,1),
    duration varchar(255)
);


drop table FACT_NETFLIX_SHOWS;
create table FACT_NETFLIX_SHOWS(
    show_id int primary key ,
    info_id int,
    type_id int,
    director_id int,
    country_id int,
    date_id int,
    rating_id int,
    duration_id int,
    constraint info_fk foreign key (info_id) references DIM_INFO(info_id),
    constraint type_fk foreign key (type_id) references DIM_TYPE(type_id),
    constraint director_fk foreign key (director_id) references DIM_DIRECTOR(director_id),
    constraint country_fk foreign key (country_id) references DIM_COUNTRY(country_id),
    constraint date_fk foreign key (date_id) references DIM_DATE(date_id),
    constraint rating_fk foreign key (rating_id) references DIM_RATING(rating_id),
    constraint duration_fk foreign key (duration_id) references DIM_DURATION(duration_id),
);



create procedure LOAD_DIM_COUNTRY
AS
    insert into DIM_COUNTRY (country)
    select distinct source.country
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_COUNTRY dim
                               where dim.country = source.country);
GO


create procedure LOAD_DIM_DATE
AS
    insert into DIM_DATE (date_added, release_year)
    select distinct source.date_added, source.release_year
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_DATE dim
                               where dim.date_added = source.date_added and  dim.release_year = source.release_year);
GO;



create procedure LOAD_DIM_DIRECTOR
AS
    insert into DIM_DIRECTOR (director)
    select distinct source.director
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_DIRETOR dim
                               where dim.director = source.director);
GO


create procedure LOAD_DIM_DURATION
AS
    insert into DIM_DURATION (duration)
    select distinct source.duration
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_DURATION dim
                               where dim.duration = source.duration);
GO


create procedure LOAD_DIM_INFO
AS
    insert into DIM_INFO (tilte, listed_in,description, cast)
    select distinct source.title, source.listed_in, source.description, source.cast
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_INFO dim
                               where dim.tilte = source.title and dim.listed_in = source.listed_in and dim
                                   .description = source.description and dim.cast = source.cast);
GO



create procedure LOAD_DIM_RATING
AS
    insert into DIM_RATING (rating)
    select distinct source.rating
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_RATING dim
                               where dim.rating = source.rating);
GO

create procedure LOAD_DIM_TYPE
AS
    insert into DIM_TYPE (type)
    select distinct source.type
    from asm3_cs4_source.dbo.netflix_titles source
    where not exists (select 1 from DIM_TYPE dim
                               where dim.type = source.type);
GO


create procedure LOAD_FACT_NETFLIX_SHOWS
As
    insert into FACT_NETFLIX_SHOWS (show_id,info_id,type_id,director_id, country_id,date_id, rating_id, duration_id)
    select source.show_id,dim_info.info_id, dim_type.type_id, dim_director.director_id, dim_country.country_id,dim_date
        .date_id, dim_rating.rating_id,dim_duration.duration_id
    from asm3_cs4_source.dbo.netflix_titles source
    left join dim_country on dim_country.country = source.country
    left join dim_date on dim_date.date_added = source.date_added and dim_date.release_year = source.release_year
    left join dim_director on dim_director.director = source.director
    left join dim_duration on dim_duration.duration = source.duration
    left join dim_info on dim_info.tilte = source.title and dim_info.listed_in = source.listed_in and dim_info
        .description = source.description and dim_info.cast = source.cast
    left join dim_rating on dim_rating.rating = source.rating
    left join dim_type on dim_type.type = source.type
    where not exists (select 1 from fact_netflix_shows where source.show_id = fact_netflix_shows.show_id);
go




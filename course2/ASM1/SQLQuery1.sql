use ASM1_cs2
GO

create table Type_DIM(
	Type_id int primary key identity,
	Type varchar(255)
);

create table Color_DIM(
	Color_id int primary key identity,
	Color varchar(255)
);

create table Vaccinated_DIM(
	Vaccinated_id int primary key identity,
	Vaccinated varchar(255)
);


create table Health_DIM(
	Health_id int primary key identity,
	Health varchar(255)
);



create table Dewormed_DIM(
	Dewormed_id int primary key identity,
	Dewormed varchar(255)
);


create table Breed_DIM(
	Breed_id int primary key identity,
	Breed varchar(255)
);




create table FurLength_DIM(
	FurLength_id int primary key identity,
	FurLength varchar(255)
);




create table MarturitySize_DIM(
	MarturitySize_id int primary key identity,
	MarturitySize varchar(255)
);




create table Sterilized_DIM(
	Sterilized_id int primary key identity,
	Sterilized varchar(255)
);




create table State_DIM(
	State_id int primary key identity,
	State varchar(255)
);



create table Gender_DIM(
	Gender_id int primary key identity,
	Gender varchar(255)
);





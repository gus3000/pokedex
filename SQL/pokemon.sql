create database pokemon;

drop table if exists type;
create table type
(
    type_id int primary key,
    name varchar(10) not null
);

drop table if exists ability;
create table ability
(
    ability_id int primary key,
    name varchar(10) not null
);

drop table if exists category;
create table category
(
    category_id int primary key,
    name varchar(10) not null
);

drop table if exists pokemon;
create table pokemon
(
    pokemon_id   int primary key,
	numero       varchar(4),
    name         varchar(20) unique,
    type1        int,
    type2        int null,
	evolves_from int null,
	height       float,
	weight 		 float,
	ability_id   int,
	category_id  int,
    constraint foreign key (type1) references type (type_id),
    constraint foreign key (type2) references type (type_id),
    constraint foreign key (evolves_from) references pokemon (pokemon_id),
	constraint foreign key (ability_id) references ability (ability_id),
	constraint foreign key (category_id) references category (category_id)
);

drop table if exists stats;
create table stats
(
    stat_id    int primary key,
    name       varchar(20) unique
);

drop table if exists relation;
create table pokemon_stats
(
    pokemon_id int,
	stat_id    int,
    base_stat  TINYINT UNSIGNED,
    constraint primary key (pokemon_id, stat_id),
    constraint foreign key (stat_id) references stats (stat_id),
    constraint foreign key (pokemon_id) references pokemon (pokemon_id)
);

drop table if exists relation;
create table relation
(
    label char(1) primary key -- X, / ou 0
);

drop table if exists relation_type;
create table relation_type
(
    type1    int,
    type2    int,
    relation char(1),
    primary key (type1, type2),
    foreign key (relation) references relation (label),
    foreign key (type1) references type (type_id),
    foreign key (type2) references type (type_id)
);


insert into type (type_id,name)
values (1,'NORMAL'),
       (2,'FIGHTING'),
       (3,'FLYING'),
       (4,'POISON'),
       (5,'GROUND'),
       (6,'ROCK'),
       (7,'BUG'),
       (8,'GHOST'),
       (9,'STEEL'),
       (10,'FIRE'),
       (11,'WATER'),
       (12,'GRASS'),
       (13,'ELECTRIC'),
       (14,'PSYCHIC'),
       (15,'ICE'),
       (16,'DRAGON'),
       (17,'DARK'),
       (18,'FAIRY');

insert into relation_type (type1, type2, relation)
values (1,6,'/')
     , (1,8,'0')
     , (1,9,'/')

     , (10,10,'/')
     , (10,11,'/')
     , (10,12,'X')
     , (10,15,'X')
     , (10,7,'X')
     , (10,6,'/')
     , (10,16,'/')
     , (10,9,'X')

     , (11,10,'X')
     , (11,11,'/')
     , (11,12,'/')
     , (11,5,'X')
     , (11,6,'X')
     , (11,16,'/')

     , (13,11,'X')
     , (13,13,'/')
     , (13,12,'/')
     , (13,5,'0')
     , (13,3,'X')
     , (13,16,'/')

     , (12,10,'/')
     , (12,11,'X')
     , (12,12,'/')
     , (12,4,'/')
     , (12,5,'X')
     , (12,3,'/')
     , (12,7,'/')
     , (12,6,'X')
     , (12,16,'/')
     , (12,9,'/')

     , (15,10,'/')
     , (15,11,'/')
     , (15,12,'X')
     , (15,15,'/')
     , (15,5,'X')
     , (15,3,'X')
     , (15,16,'X')
     , (15,9,'/')

     , (2,1,'X')
     , (2,15,'X')
     , (2,4,'/')
     , (2,3,'/')
     , (2,14,'/')
     , (2,7,'/')
     , (2,6,'X')
     , (2,8,'0')
     , (2,17,'X')
     , (2,9,'X')
     , (2,18,'/')

     , (4,12,'X')
     , (4,4,'/')
     , (4,5,'/')
     , (4,6,'/')
     , (4,8,'/')
     , (4,9,'0')
     , (4,18,'X')

     , (5,10,'X')
     , (5,13,'X')
     , (5,12,'/')
     , (5,4,'X')
     , (5,3,'0')
     , (5,7,'/')
     , (5,6,'X')
     , (5,9,'X')

     , (3,13,'/')
     , (3,12,'X')
     , (3,2,'X')
     , (3,7,'X')
     , (3,6,'/')
     , (3,9,'/')

     , (14,2,'X')
     , (14,4,'X')
     , (14,14,'/')
     , (14,17,'0')
     , (14,9,'/')

     , (7,10,'/')
     , (7,12,'X')
     , (7,2,'/')
     , (7,4,'/')
     , (7,3,'/')
     , (7,14,'X')
     , (7,8,'/')
     , (7,17,'X')
     , (7,9,'/')
     , (7,18,'/')

     , (6,10,'X')
     , (6,15,'X')
     , (6,2,'/')
     , (6,5,'/')
     , (6,3,'X')
     , (6,7,'X')
     , (6,9,'/')

     , (8,1,'0')
     , (8,14,'X')
     , (8,8,'X')
     , (8,17,'/')

     , (16,16,'X')
     , (16,9,'/')
     , (16,18,'0')

     , (17,2,'/')
     , (17,14,'X')
     , (17,8,'X')
     , (17,17,'/')
     , (17,18,'/')

     , (9,10,'/')
     , (9,11,'/')
     , (9,13,'/')
     , (9,15,'X')
     , (9,6,'X')
     , (9,9,'/')
     , (9,18,'X')

     , (18,10,'/')
     , (18,2,'X')
     , (18,4,'/')
     , (18,16,'X')
     , (18,17,'X')
     , (18,9,'/');



	 
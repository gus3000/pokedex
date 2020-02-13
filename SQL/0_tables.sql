drop table if exists ability, category, pokemon, pokemon_ability, pokemon_stats, relation, relation_type, stats, type;
create table type
(
    type_id int primary key,
    name    varchar(10) not null

) comment 'bla';

create table ability
(
    ability_id int primary key,
    name       varchar(20) not null
);

create table category
(
    category_id int primary key,
    name        varchar(20) not null
);

create table pokemon
(
    pokemon_id  int primary key,
    name        varchar(20) unique,
    type1       int,
    type2       int null,
# 	evolves_from int null,
    height      float,
    weight      float,
    category_id int,
    constraint foreign key (type1) references type (type_id),
    constraint foreign key (type2) references type (type_id),
#     constraint foreign key (evolves_from) references pokemon (pokemon_id),
    constraint foreign key (category_id) references category (category_id)
);

create table stats
(
    stat_id int primary key,
    name    varchar(20) unique
);

create table pokemon_stats
(
    pokemon_id int,
    stat_id    int,
    base_stat  TINYINT UNSIGNED,
    constraint primary key (pokemon_id, stat_id),
    constraint foreign key (stat_id) references stats (stat_id),
    constraint foreign key (pokemon_id) references pokemon (pokemon_id)
);

create table pokemon_ability
(
    pokemon_id int,
    ability_id int,
    is_hidden  bool,
    slot       int,
    constraint primary key (pokemon_id, ability_id),
    constraint foreign key (pokemon_id) references pokemon (pokemon_id),
    constraint foreign key (ability_id) references ability (ability_id)
);

create table relation
(
    label char(1) primary key -- X, / ou 0
);

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

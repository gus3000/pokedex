const mysql = require('mysql');

let connection;
if (connection === undefined) {
    connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'passwd',
        database: 'pokedex'
    });
}

exports.getAllPokemon = function (callback) {
    connection.query("select pokemon_id, pokemon.name as name, height, weight, t1.name as type1, t2.name as type2 from pokemon \
        inner join type t1 on pokemon.type1 = t1.type_id \
        left join type t2 on pokemon.type2 = t2.type_id\
        order by pokemon_id", (error, results) => {
        console.log(results);
        callback(results);
    });
};

exports.getPokemon = function (indice, callback) {
    connection.query("select pokemon.pokemon_id\
         , pokemon.name\
         , pokemon.height\
         , pokemon.weight\
         , t1.name                                    as type1\
         , t2.name                                    as type2\
         , c.name                                     as category\
         , max(case when pa.slot = 1 then a.name end) as ability1\
         , max(case when pa.slot = 2 then a.name end) as ability2\
         , max(case when pa.slot = 3 then a.name end) as ability3\
         , max(case when s.name = 'Attack' then ps.base_stat end) as 'Attack'\
         , max(case when s.name = 'Defense' then ps.base_stat end) as 'Defense'\
         , max(case when s.name = 'HP' then ps.base_stat end) as 'HP'\
         , max(case when s.name = 'Special Attack' then ps.base_stat end) as 'Special Attack'\
         , max(case when s.name = 'Special Defense' then ps.base_stat end) as 'Special Defense'\
         , max(case when s.name = 'Speed' then ps.base_stat end) as 'Speed'\
    from pokemon\
             inner join pokemon_ability pa on pokemon.pokemon_id = pa.pokemon_id\
             inner join ability a on pa.ability_id = a.ability_id\
             inner join type t1 on pokemon.type1 = t1.type_id\
             left join type t2 on pokemon.type2 = t2.type_id\
             inner join category c on pokemon.category_id = c.category_id\
             inner join pokemon_stats ps on pokemon.pokemon_id = ps.pokemon_id\
             inner join stats s on ps.stat_id = s.stat_id\
    where pokemon.pokemon_id = ?\
    group by pokemon.pokemon_id\
    order by pokemon.pokemon_id",
        [indice],
        (error, results) => {
            if (error) throw error;
            callback(results[0]);
        })
};

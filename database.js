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

exports.getPokemon = function(indice, callback) {

};

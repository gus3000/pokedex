#!/usr/bin/env node

const glob = require('glob');
const mysql = require("mysql");
const fs = require('fs');

class DBCreator {
    constructor() {
        this.setup();
        this.tryConnecting()
            .then(() => {
                console.log("Database online. Executing all scripts in the SQL directory.");
                this.executeAllInDirectory(__dirname).then(/* Do nothing */);
            })
            .catch(() => console.error("There may have been a problem with the database : " +
                "check the docker-compose.yml, then try running `docker-compose up` manually, and try again"));
    }

    setup() {
        this.connection = mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: 'passwd',
            database: 'pokedex'
        });
    }

    sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    /**
     * A beginner's recursive Promise. Please be gentle.
     * @param tries
     * @returns {Promise<void>}
     */
    tryConnecting(tries = 10) {
        return new Promise((resolve, reject) => {
            if (tries === 0) {
                this.connection.end();
                console.error("Unable to connect");
                return reject();
            }
            this.connection.connect((err) => {
                if (err !== null) {
                    console.log("Database not available. Trying again in 5 seconds...");
                    this.sleep(5000).then(() => {
                        this.setup();
                        this.tryConnecting(tries - 1)
                            .then(() => resolve())
                            .catch(() => reject());
                    });

                } else {
                    resolve();
                }
            });
        });

    }

    async executeAllInDirectory(directory) {
        let files = glob.sync(directory + '/*.sql');
        let sqlString = '';
        for (let file of files) {
            let sql = fs.readFileSync(file, "utf8");
            // console.log(sql);
            sqlString += sql;
        }
        let queries = sqlString.split(';');
        // console.log("old string :", sqlString);
        // sqlString = sqlString.replace(/\r?\n|\r/g, ' ');
        // sqlString = sqlString.replace("select","bla");
        // console.log("new string :", sqlString);
        this.executeQueries(queries);
    }

    executeQueries(queries, index = 0) {
        if (index >= queries.length) {
            this.connection.end();
            console.log("Database is running and populated.");
            return;
        }
        if (/^\s*$/g.exec(queries[index]) === null) {
            this.connection.query(queries[index], (err) => {
                if (err) {
                    console.log("query :'" + queries[index] + "'");
                    throw err;
                }
                console.log("[" + (index + 1) + "/" + queries.length + "] OK");
                this.executeQueries(queries, index + 1);
            });
        } else {
            console.log("[" + (index + 1) + "/" + queries.length + "] OK");
            this.executeQueries(queries, index + 1);
        }


    }
}

new DBCreator();

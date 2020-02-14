# Pokedex3000 ![Node.js CI](https://github.com/gus3000/pokedex/workflows/Node.js%20CI/badge.svg)

This is a simple Pokedex app, attempting to mirror https://www.pokemon.com/us/pokedex/.

## Dependencies
You just need `docker-compose` and `npm`, and you should be good to go.

## Initialize the project
To initialize the project, first install all the dependencies :
```bash
npm install
```
then create the database :
```bash
npm run dbcreate
``` 
then simply start the project :
```bash
npm start
```

## Start the project
`npm start` automatically starts the database, so next time you want to start the project, you only have to call it.
You can also bring the database down manually with :
```bash
docker-compose down
```

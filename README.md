#Connecter un serveur Node.js et une bdd MongoDB

*Lancement sans dockerfile*

Créer le volume (mydata).
```shell
docker volume create mydata
```
Créer un conteneur à partir d'une image mongo, en précisant: le nom (db), la connexion au volume.
```shell
docker run -d --name db --mount type=volume,src=mydata,target=/data/db mongo
```
Créer un réseau (mynet).
```shell
docker network create mynet
```
Connecter le conteneur au réseau.
```shell
docker network connect mynet db
docker inspect mynet #pour vérification
```
Se connecter au conteneur mongo, y créer une base de données (test) et insérer un objet "count" initialisé à zéro dans une une collection (count)
```shell
docker exec -it db mongo
> use test
> db.count.insertOne({count:0})
> show dbs
> exit
```
Builder l'image node-server à partir du Dockerfile, en ayant au préalable ajouté le packge mongodb au package.json
```shell
docker build -t server .
```
Lancer un conteneur à partir de cette image, en lui donnant un nom (server), sans oublier de créer le mount-bind de développement, d'ouvrir les port ver le localhost, et le le connecter au même réseau que le conteneur mongo.
```shell
docker run -d --name server --mount type=bind,source="$(pwd)"/src,target=/app/src/ -p 8081:80 --network mynet server
```


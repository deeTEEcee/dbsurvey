### HBase Docker suite and Java application

## HBase Docker
Two different flavors - standalone (single ResourceManager, no Hadoop DFS, uses local filesystem) and distributed (comes with HDFS and supports two RegionServers).

Base images are of bde2020 (Big Data Europe) variety: https://hub.docker.com/r/bde2020/hbase-master

In order to enable Snappy compression, I had to collect pre-compiled libraries and include them externally, so HDFS NameNode and DataNode, as well as HBase Master and RegionServer images need to be built in `docker` directory:

```shell
cd docker
docker build -f Dockerfile-namenode-snappy -t amastilovic/namenode-snappy:1.0 .
docker build -f Dockerfile-datanode-snappy -t amastilovic/datanode-snappy:1.0 .
docker build -f Dockerfile-master-snappy -t amastilovic/hbase-master-snappy:1.0 .
docker build -f Dockerfile-region-snappy -t amastilovic/hbase-region-snappy:1.0 .
```

Once the images are built, we can run the docker compose for standalone:

```shell
docker-compose --compatibility -f hbase-standalone.yml up -d
```

or, for fully distributed using HDFS:

```shell
docker-compose --compatibility -f hbase-distributed-local.yml scale hbase-regionserver=2
```

## Java application
Provided in the `app` directory is a small Java app that can interact with/between HBase and Postgress running in Docker compose.

It provides three functions:

```
transfer
hbase
postgres
```

`transfer` will transfer table `analytics_lacquer` from Postgres to HBase.

`hbase` will run a query on HBase and output the results to stdout.

`postgres` will run a query on Postgres and output the results to stdout.

Application is a Maven project, so if you have Maven simply cd into the directory and run

```bash
mvn clean package
```

This should create a shaded jar file in `target/hbase-app-1.0-SNAPSHOT.jar` which you can then run with

```bash
java -jar target/hbase-app-1.0-SNAPSHOT.jar
```

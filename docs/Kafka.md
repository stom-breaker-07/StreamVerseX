#Kafka

#### To generate a random uuid
> bin\windows\kafka-storage.bat random-uuid

ex :  v4sIzHQuQn2_RIOoza09Bw

#### To configure the Cluster
> bin\windows\kafka-storage.bat format -t v4sIzHQuQn2_RIOoza09Bw -c config\kraft\server.properties

#### To Start the server in one terminal T1
>bin\windows\kafka-server-start.bat config\kraft\server.properties

#### To Create A topic in Kafka T2
>bin\windows\kafka-topics.bat --create --topic test --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

#### To see the lists of Topic created
> bin\windows\kafka-topics.bat --bootstrap-server localhost:9092 --list

#### To create a producer listening terminal T2
> bin\windows\kafka-console-producer.bat --topic messenger --bootstrap-server localhost:9092

#### To Create a consumer listening terminal T3
> bin\windows\kafka-console-consumer.bat --topic messenger --from-beginning --bootstrap-server localhost:9092
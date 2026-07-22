import json

from kafka import KafkaConsumer

from database import get_connection
from inserts import insert_user_journey


conn = get_connection()

consumer = KafkaConsumer(
    "streamverse-events",
    bootstrap_servers="localhost:9092",
    auto_offset_reset="latest",
    enable_auto_commit=True,
    group_id="streamverse-group",
    value_deserializer=lambda x: json.loads(
        x.decode("utf-8")
    )
)

print("🚀 StreamVerse Kafka Consumer Started...")

try:

    for message in consumer:

        journey = message.value

        insert_user_journey(
            conn,
            journey
        )

        print("✅ Journey Inserted Into PostgreSQL")

except KeyboardInterrupt:

    consumer.close()

    conn.close()

    print("Consumer Stopped")
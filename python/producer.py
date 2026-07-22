import json
import time
from datetime import datetime

from kafka import KafkaProducer

from data_generator import StreamVerseGenerator


producer = KafkaProducer(
    bootstrap_servers="localhost:9092",
    value_serializer=lambda v: json.dumps(
        v,
        default=str
    ).encode("utf-8")
)


generator = StreamVerseGenerator()

generator.load_master_data()

print("🚀 StreamVerse Kafka Producer Started")


try:

    while True:

        journey = generator.generate_user_journey()

        producer.send(
            "streamverse-events",
            journey
        )

        producer.flush()

        print("✅ Journey Sent To Kafka")

        time.sleep(2)

except KeyboardInterrupt:

    producer.close()

    generator.conn.close()

    print("Producer Stopped")
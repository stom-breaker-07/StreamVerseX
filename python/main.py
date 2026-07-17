import time

from data_generator import StreamVerseGenerator
from inserts import insert_user_journey

generator = StreamVerseGenerator()

generator.load_master_data()

print("StreamVerse Live Generator Started...")

try:

    while True:

        journey = generator.generate_user_journey()

        insert_user_journey(
            generator.conn,
            journey
        )

        print("Scanning Network " , end="")
        for i in range(5):
            time.sleep(1)
            print(".", end="", flush=True)
                
        time.sleep(2)

except KeyboardInterrupt:

    print("\n🛑 Generator Stopped")

    generator.conn.close()
    
    
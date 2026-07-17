import random
import uuid
from datetime import datetime

import pandas as pd

from database import get_connection

from utils import (
    get_device,
    get_quality,
    get_session_status,
    get_search_query,
    get_screen,
    get_click_action,
    get_region,
    get_server_region,
    get_plan,
    get_payment_mode,
    get_payment_status,
    get_renewal_status,
    get_failure_code
)


class StreamVerseGenerator:

    def __init__(self):

        self.conn = get_connection()

        self.users = None
        self.content = None

    def load_master_data(self):

        self.users = pd.read_sql(
            "SELECT * FROM ott.users;",
            self.conn
        )

        self.content = pd.read_sql(
            "SELECT * FROM ott.content_metadata;",
            self.conn
        )

        print(f"✅ Users Loaded : {len(self.users)}")
        print(f"✅ Content Loaded : {len(self.content)}")
        
    def get_random_user(self):

        return self.users.sample(1).iloc[0]

    def get_random_content(self):

        return self.content.sample(1).iloc[0]
    
    def generate_timestamp(self):

        return datetime.now().replace(microsecond=0)
    
    def generate_ids(self):

        return {

            "session_id":
                "SES" + uuid.uuid4().hex[:9].upper(),

            "watch_id":
                "WH" + uuid.uuid4().hex[:8].upper(),

            "search_id":
                "SRCH" + uuid.uuid4().hex[:8].upper(),

            "click_id":
                "CLK" + uuid.uuid4().hex[:9].upper(),

            "cdn_event_id":
                "CDN" + uuid.uuid4().hex[:9].upper(),

            "transaction_id":
                "SUB" + uuid.uuid4().hex[:9].upper()

        }
        
    def generate_streaming_session(self, user, content, ids, timestamp):

        device = get_device()

        quality = get_quality()

        status = get_session_status()

        duration_minutes = int(content["duration_minutes"])

        if status == "Completed":

            watch_duration = random.randint(
                int(duration_minutes * 0.80 * 60),
                duration_minutes * 60
            )

        elif status == "Paused":

            watch_duration = random.randint(
                int(duration_minutes * 0.40 * 60),
                int(duration_minutes * 0.75 * 60)
            )

        else:

            watch_duration = random.randint(
                60,
                int(duration_minutes * 0.30 * 60)
            )

        buffering = round(random.uniform(0.2, 25.0), 2)

        return {

            "session_id": ids["session_id"],

            "user_id": user["user_id"],

            "content_id": content["content_id"],

            "device_type": device,

            "stream_quality": quality,

            "watch_duration": watch_duration,

            "buffering_time": buffering,

            "session_status": status,

            "session_timestamp": timestamp

        }
    
    def generate_search_log(self, user, content, ids, timestamp):

        return {

            "search_id": ids["search_id"],

            "user_id": user["user_id"],

            "search_query": get_search_query(),

            "recommended_content": content["content_id"],

            "clicked_content": content["content_id"],

            "recommendation_score": round(
                random.uniform(0.75,0.99),
                2
            ),

            "search_timestamp": timestamp

        }
    
    def generate_watch_history(self, user, content, session):

        watch_time = int(session["watch_duration"])

        duration = int(content["duration_minutes"] * 60)

        completion = round(
            (watch_time / duration) * 100,
            2
        )

        completion = min(completion,100)

        return {

            "watch_id": session["session_id"].replace("SES","WH"),

            "user_id": user["user_id"],

            "content_id": content["content_id"],

            "content_category": content["genre"],

            "watch_time": watch_time,

            "completion_rate": completion,

            "pause_count": random.randint(0,5),

            "skip_count": random.randint(0,8),

            "region": get_region()

        }
        
    def generate_clickstream(self, user, ids, timestamp):

        return {

            "click_id": ids["click_id"],

            "user_id": user["user_id"],

            "screen_name": get_screen(),

            "click_action": get_click_action(),

            "session_duration": random.randint(5, 300),

            "crash_flag": random.choices(
                [False, True],
                weights=[97, 3],
                k=1
            )[0],

            "event_timestamp": timestamp

        }
        
    def generate_cdn_log(self, session, ids, timestamp):

        buffering = session["buffering_time"]

        if buffering < 15:
            return None

        return {

            "cdn_event_id": ids["cdn_event_id"],

            "server_region": get_server_region(),

            "latency": round(random.uniform(50, 350), 2),

            "packet_loss": round(random.uniform(0.1, 5.0), 2),

            "buffering_spike": True,

            "failure_code": get_failure_code(),

            "event_timestamp": timestamp

        }
        
    def generate_subscription(self, user, ids, timestamp):

        if random.randint(1, 100) > 5:
            return None

        status = get_payment_status()

        return {

            "transaction_id": ids["transaction_id"],

            "user_id": user["user_id"],

            "plan_type": get_plan(),

            "subscription_amount": round(
                random.uniform(299, 1999),
                2
            ),

            "payment_mode": get_payment_mode(),

            "payment_status": status,

            "renewal_status": get_renewal_status(),

            "transaction_timestamp": timestamp

        }
        
    def generate_user_journey(self):

        user = self.get_random_user()

        content = self.get_random_content()

        ids = self.generate_ids()

        timestamp = self.generate_timestamp()

        streaming = self.generate_streaming_session(
            user,
            content,
            ids,
            timestamp
        )

        return {

            "streaming": streaming,

            "watch": self.generate_watch_history(
                user,
                content,
                streaming
            ),

            "search": self.generate_search_log(
                user,
                content,
                ids,
                timestamp
            ),

            "clickstream": self.generate_clickstream(
                user,
                ids,
                timestamp
            ),

            "cdn": self.generate_cdn_log(
                streaming,
                ids,
                timestamp
            ),

            "subscription": self.generate_subscription(
                user,
                ids,
                timestamp
            )

        }
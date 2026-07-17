from psycopg2 import Error

def insert_streaming_session(conn, session):

    try:

        cursor = conn.cursor()

        query = """
        INSERT INTO ott.video_streaming_sessions
        (
            session_id,
            user_id,
            content_id,
            device_type,
            stream_quality,
            watch_duration,
            buffering_time,
            session_status,
            session_timestamp
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s,%s,%s,%s
        );
        """

        values = (

            session["session_id"],
            session["user_id"],
            session["content_id"],
            session["device_type"],
            session["stream_quality"],
            session["watch_duration"],
            session["buffering_time"],
            session["session_status"],
            session["session_timestamp"]

        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        print("✅ Streaming Session Inserted")

    except Error as e:

        conn.rollback()

        print("❌ Streaming Insert Failed")

        print(e)

def insert_watch_history(conn, watch):

    try:

        cursor = conn.cursor()

        query = """
        INSERT INTO ott.user_watch_history
        (
            watch_id,
            user_id,
            content_id,
            content_category,
            watch_time,
            completion_rate,
            pause_count,
            skip_count,
            region
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s,%s,%s,%s
        );
        """

        values = (

            watch["watch_id"],
            watch["user_id"],
            watch["content_id"],
            watch["content_category"],
            watch["watch_time"],
            watch["completion_rate"],
            watch["pause_count"],
            watch["skip_count"],
            watch["region"]

        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        print("✅ Watch History Inserted")

    except Error as e:

        conn.rollback()

        print("❌ Watch History Insert Failed")

        print(e)
        
def insert_search_log(conn, search):

    try:

        cursor = conn.cursor()

        query = """
        INSERT INTO ott.search_recommendation_logs
        (
            search_id,
            user_id,
            search_query,
            recommended_content,
            clicked_content,
            recommendation_score,
            search_timestamp
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s,%s
        );
        """

        values = (

            search["search_id"],
            search["user_id"],
            search["search_query"],
            search["recommended_content"],
            search["clicked_content"],
            search["recommendation_score"],
            search["search_timestamp"]

        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        print("✅ Search Log Inserted")

    except Error as e:

        conn.rollback()

        print("❌ Search Log Insert Failed")

        print(e)
        
def insert_clickstream(conn, clickstream):

    try:

        cursor = conn.cursor()

        query = """
        INSERT INTO ott.app_clickstream_events
        (
            click_id,
            user_id,
            screen_name,
            click_action,
            session_duration,
            crash_flag,
            event_timestamp
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s,%s
        );
        """

        values = (

            clickstream["click_id"],
            clickstream["user_id"],
            clickstream["screen_name"],
            clickstream["click_action"],
            clickstream["session_duration"],
            clickstream["crash_flag"],
            clickstream["event_timestamp"]

        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        print("✅ Clickstream Inserted")

    except Error as e:

        conn.rollback()

        print("❌ Clickstream Insert Failed")

        print(e)
        
def insert_cdn_log(conn, cdn):

    if cdn is None:
        return

    try:

        cursor = conn.cursor()

        query = """
        INSERT INTO ott.cdn_buffering_logs
        (
            cdn_event_id,
            server_region,
            latency,
            packet_loss,
            buffering_spike,
            failure_code,
            event_timestamp
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s,%s
        );
        """

        values = (

            cdn["cdn_event_id"],
            cdn["server_region"],
            cdn["latency"],
            cdn["packet_loss"],
            cdn["buffering_spike"],
            cdn["failure_code"],
            cdn["event_timestamp"]

        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        print("✅ CDN Log Inserted")

    except Error as e:

        conn.rollback()

        print("❌ CDN Insert Failed")

        print(e)
        
def insert_subscription(conn, subscription):

    if subscription is None:
        return

    try:

        cursor = conn.cursor()

        query = """
        INSERT INTO ott.subscription_transactions
        (
            transaction_id,
            user_id,
            plan_type,
            subscription_amount,
            payment_mode,
            payment_status,
            renewal_status,
            transaction_timestamp
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s,%s,%s
        );
        """

        values = (

            subscription["transaction_id"],
            subscription["user_id"],
            subscription["plan_type"],
            subscription["subscription_amount"],
            subscription["payment_mode"],
            subscription["payment_status"],
            subscription["renewal_status"],
            subscription["transaction_timestamp"]

        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        print("✅ Subscription Inserted")

    except Error as e:

        conn.rollback()

        print("❌ Subscription Insert Failed")

        print(e)
        
def insert_user_journey(conn, journey):

    insert_streaming_session(
        conn,
        journey["streaming"]
    )

    insert_watch_history(
        conn,
        journey["watch"]
    )

    insert_search_log(
        conn,
        journey["search"]
    )

    insert_clickstream(
        conn,
        journey["clickstream"]
    )

    insert_cdn_log(
        conn,
        journey["cdn"]
    )

    insert_subscription(
        conn,
        journey["subscription"]
    )
import psycopg2
from config import *


def get_connection():
    return psycopg2.connect(
        host=DB_HOST, port=DB_PORT, database=DB_NAME, user=DB_USER, password=DB_PASSWORD
    )


def insert_streaming_session(conn, session):

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
        session["session_timestamp"],
    )

    cursor.execute(query, values)

    conn.commit()

    cursor.close()

    print("✅ Streaming Session Inserted Successfully")

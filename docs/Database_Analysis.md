# Database Analysis

| Table | Keep | Modify | Reason |
|-------|------|---------|--------|
| users | ✅ Create | Populate later | Parent table |
| content_metadata | ✅ Keep | Rating changed to DECIMAL(3,1) | CSV contains value 10 |
| video_streaming_sessions | ✅ Keep | Rename video_id/content_id consistently | Better naming |
| user_watch_history | ✅ Keep | Add content_id later | Normalization |
| subscription_transactions | ✅ Keep | No changes | Matches CSV |
| app_clickstream_events | ✅ Keep | No changes | Matches CSV |
| search_recommendation_logs | ✅ Keep | Column order fixed | CSV mismatch |
| cdn_buffering_logs | ✅ Keep | buffering_spike BOOLEAN | CSV contains TRUE/FALSE |

# StreamVerseX Data Dictionary

## users

| Column | Data Type | Description |
|---------|-----------|-------------|
| user_id | INT | Unique User ID |
| account_created_date | DATE | Account creation date |
| account_status | VARCHAR(20) | Active / Inactive |

---

## content_metadata

| Column | Data Type | Description |
|---------|-----------|-------------|
| content_id | VARCHAR(20) | Unique Content ID |
| genre | VARCHAR(50) | Genre |
| release_date | DATE | Release date |
| language | VARCHAR(30) | Language |
| duration_minutes | INT | Duration in minutes |
| rating | DECIMAL(3,1) | IMDb-style rating |
| production_studio | VARCHAR(100) | Studio name |

---

## video_streaming_sessions

| Column | Data Type | Description |
|---------|-----------|-------------|
| session_id | VARCHAR(20) | Streaming session ID |
| user_id | INT | User ID |
| video_id | VARCHAR(20) | Content ID |
| device_type | VARCHAR(20) | Mobile / TV / Laptop |
| stream_quality | VARCHAR(10) | 480p / 720p / 1080p / 4K |
| watch_duration | DECIMAL(8,2) | Minutes watched |
| buffering_time | DECIMAL(8,2) | Buffering time |
| session_status | VARCHAR(20) | Completed / Paused / Dropped |
| session_timestamp | TIMESTAMP | Session timestamp |

---

## user_watch_history

| Column | Data Type | Description |
|---------|-----------|-------------|
| watch_id | VARCHAR(20) | Watch ID |
| user_id | INT | User ID |
| content_category | VARCHAR(50) | Category |
| watch_time | DECIMAL(8,2) | Watch duration |
| completion_rate | DECIMAL(5,2) | Completion % |
| pause_count | INT | Number of pauses |
| skip_count | INT | Number of skips |
| region | VARCHAR(50) | User region |

---

## subscription_transactions

| Column | Data Type | Description |
|---------|-----------|-------------|
| transaction_id | VARCHAR(20) | Transaction ID |
| user_id | INT | User ID |
| plan_type | VARCHAR(30) | Subscription plan |
| subscription_amount | DECIMAL(10,2) | Amount paid |
| payment_mode | VARCHAR(30) | Payment method |
| payment_status | VARCHAR(20) | Success / Failed / Pending |
| renewal_status | VARCHAR(20) | Renewal status |
| transaction_timestamp | TIMESTAMP | Transaction time |

---

## app_clickstream_events

| Column | Data Type | Description |
|---------|-----------|-------------|
| click_id | VARCHAR(20) | Click ID |
| user_id | INT | User ID |
| screen_name | VARCHAR(50) | Screen |
| click_action | VARCHAR(50) | User action |
| session_duration | DECIMAL(8,2) | Session duration |
| crash_flag | BOOLEAN | App crashed |
| event_timestamp | TIMESTAMP | Event time |

---

## search_recommendation_logs

| Column | Data Type | Description |
|---------|-----------|-------------|
| search_id | VARCHAR(20) | Search ID |
| user_id | INT | User ID |
| search_query | VARCHAR(100) | User search |
| recommended_content | VARCHAR(20) | Recommended content |
| clicked_content | VARCHAR(20) | Clicked content |
| recommendation_score | DECIMAL(3,2) | Recommendation score |
| search_timestamp | TIMESTAMP | Search time |

---

## cdn_buffering_logs

| Column | Data Type | Description |
|---------|-----------|-------------|
| cdn_event_id | VARCHAR(20) | CDN Event ID |
| server_region | VARCHAR(20) | Server region |
| latency | DECIMAL(6,2) | Latency (ms) |
| packet_loss | DECIMAL(5,2) | Packet loss (%) |
| buffering_spike | BOOLEAN | Buffering spike |
| failure_code | INT | HTTP failure code |
| event_timestamp | TIMESTAMP | Event time |
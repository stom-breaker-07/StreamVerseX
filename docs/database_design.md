# StreamVerseX Database Design

## Database Name
streamversex

## Schema Name
ott

## Tables

1. video_streaming_sessions
2. user_watch_history
3. subscription_transactions
4. content_metadata
5. cdn_buffering_logs
6. app_clickstream_events
7. search_recommendation_logs

## Primary Keys

video_streaming_sessions
- session_id

user_watch_history
- watch_id

subscription_transactions
- transaction_id

content_metadata
- content_id

cdn_buffering_logs
- cdn_event_id

app_clickstream_events
- click_id

search_recommendation_logs
- search_id


## Foreign Keys

video_streaming_sessions
- user_id → users.user_id
- content_id → content_metadata.content_id

user_watch_history
- user_id → users.user_id
- content_id → content_metadata.content_id

subscription_transactions
- user_id → users.user_id

app_clickstream_events
- user_id → users.user_id

search_recommendation_logs
- user_id → users.user_id
- content_id → content_metadata.content_id
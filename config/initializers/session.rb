# Use the database for sessions instead of the cookie-based default
# Mostly as microsoft tokens are too big for cookies.
Rails.application.config.session_store :active_record_store

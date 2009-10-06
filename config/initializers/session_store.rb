# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sasstest_session',
  :secret      => '055986b1e5d4e81260c25b02924dfda8a09a7940822c344a7f2bc3717dafc92d0f2c246fdaee1ad610423525f726dec1dc4a1bf266ef4397fc5696d7f47a73ea'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_consumer_session',
  :secret      => '470204b1f6b9b98490dac22da70aa02f89b0c750d337c5883c37b460afa8f7a780a32b246f927bbdad253bd2cd50dbb165b2b7125febecea4d21b3d6fd40b542'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

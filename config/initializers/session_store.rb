Rails.application.config.session_store :cookie_store,
  key: '_your_app_session',
  domain: :all,
  same_site: :none,
  secure: true
Rails.application.config.middleware.use OmniAuth::Builder do
    # LINEログインのチャネルIDとチャネルシークレットを設定
    provider :line, ENV['LINE_CHANNEL_ID'], ENV['LINE_CHANNEL_SECRET'], scope: 'profile',
    callback_url: ENV['LINE_CALLBACK_URL']
end
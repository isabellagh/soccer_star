Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'], callback_path: '/auth/facebook/callback'

  #provider :facebook, Rails.application.credentials.facebook[:app_id], Rails.application.credentials.facebook[:app_secret] 
  
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  
  provider :google_oauth2, ENV["GOOGLE_CLIENT_KEY"],ENV["GOOGLE_CLIENT_SECRET"]
  
  #provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
   
  
end


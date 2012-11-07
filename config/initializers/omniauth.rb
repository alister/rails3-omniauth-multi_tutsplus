Rails.application.config.middleware.use OmniAuth::Builder do
  scope  = 'r_basicprofile, r_fullprofile r_emailaddress r_network'
  fields = ["id", "email-address", "first-name", "last-name", "formatted-name", "headline", 
                "location:(name)", "current-share", "summary", 
                "industry", "picture-url", "public-profile-url", "connections", #"location", 
                "api-standard-profile-request:(url)", 
                "last-modified-timestamp" ]
  provider :linkedin, "9ani2opq4pv3", "AlygboRzOM1GQczO", :scope => scope, :fields => fields
  provider :developer
end

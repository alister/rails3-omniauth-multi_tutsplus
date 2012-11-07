class SessionsController < ApplicationController


  def new
    @sessions = session
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(session[:user_id]).add_provider(auth_hash)
      render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)
      # Create the session
      session[:user_id] = auth.user.id
      render :text => "Welcome #{auth.user.name}!"
    end
  end

  # def create
  #   auth_hash = request.env['omniauth.auth']
  #   # render :text => "<pre>"+auth_hash.to_yaml+"</pre>"

  #   @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  #   if @authorization
  #     render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
  #   else
  #     user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
  #     user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  #     user.save!
  #     render :text => "Hi #{user.name}! You've signed up."
  #   end
  # end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end

end

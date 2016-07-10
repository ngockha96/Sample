class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) 
    #params[:session][:email]: submitted email
    if user && user.authenticate(params[:session][:password])
    #params[:session][:password]: sumitted password
      # Log the user in and redirect to the user's show page.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to current_user

    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      # Not quite right!
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_url
  end
end

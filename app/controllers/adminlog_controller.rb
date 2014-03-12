class AdminlogController < ApplicationController
  layout "administrador"
  
  def new

  end

  def create
  	user = User.find_by_email(params[:email])

  	if user && user.authenticate(params[:password])
  		session[:admin_id] = user.id
  		redirect_to administrador_index_path
  	else
  		flash.now.alert = "Email or password is invalid"
  		render "new"
  	end
    
  end

  def destroy
  		session[:admin_id] = nil
  		redirect_to root_url, notice: "Logged out!"
	end

end

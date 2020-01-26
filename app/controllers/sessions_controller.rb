class SessionsController < ApplicationController
  def new
  end

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in @user
=begin comment
			if session[:params][:remember_me] == '1'
				remember @user
			else
				forget @user
			end

			this ^ code is simplified and implemented below
=end
			# the 'remember' and 'forget' methods below need parentheses around their arguements
			params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
			# this remember method is from the session helper ^, not the user model
			redirect_to @user
		else
			#this flash persists for one page because of the ".now"
			flash.now[:danger] = "Invalid username/password combination"
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end

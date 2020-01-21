class SessionsController < ApplicationController
  def new
  end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			# this remember is from the session helper, not the user model
			remember user
			redirect_to user
		else
			#this flash persists for one page because of the ".now"
			flash.now[:danger] = "Invalid username/password combination"
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end
end

class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	private
		def logged_in_user
			#logged_in? comes from sessions_helper.rb
			unless logged_in?
				store_location
				flash[:danger] = "Please log in"
				redirect_to login_url
			end
		end
end

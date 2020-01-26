ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

	def testv_logged_in?
		!session[:user_id].nil?
	end

	def testv_log_in(user)
		session[:user_id] = user.id
	end
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
	def testv_log_in(user, password: 'password', remember_me: '1')
		post login_path, params:{session:{email: user.email, password: password, remember_me: remember_me}}
	end
end

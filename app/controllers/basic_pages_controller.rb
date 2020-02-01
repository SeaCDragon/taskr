class BasicPagesController < ApplicationController
  def home
		@project = current_user.projects.build if logged_in?
  end

  def about
  end

  def help
  end
end

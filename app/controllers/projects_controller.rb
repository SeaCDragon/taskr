class ProjectsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@project = current_user.projects.build(project_params)
		if @project.save
			flash[:success] = "project created"
			redirect_to current_user
		else
			render 'basic_pages/home'
		end
	end

	def destroy
		@project.destroy
		flash[:success] = "Project deleted"
		redirect_to request.referrer || root_url
	end

	def show
		@project = Project.find(params[:id])
		@tasks = @project.tasks.paginate(page: params[:page])
	end

	private
		def project_params
			params.require(:project).permit(:title)
		end

		def correct_user
			@project = current_user.projects.find_by(id: params[:id])
			redirect_to root_url if @project.nil?
		end
end

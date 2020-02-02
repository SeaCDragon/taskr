class TasksController < ApplicationController
	def create
		@project = Project.find(params[:project_id])
		@task = @project.tasks.build(task_params)
		if @task.save
			redirect_to @project
		else
			redirect_to 'basic_pages/home'
		end
	end

	def destroy
		@task = @project.tasks.find_by(id: params[:id])
		@task.destroy
		redirect_to request.referrer || root_url
	end

	private
		def task_params
			params.require(:task).permit(:content)
		end
end

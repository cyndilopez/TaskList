class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:id)
  end

  def show
    # params instance of actioncontroller::params
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    unless @task
      redirect_to tasks_path, flash: {error: "Could not find task with id: #{task_id}"}
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      # name: params["task"]["name"],
      # description: params["task"]["description"],
      task_params
    )
    task.save
    redirect_to task_path(task.id) # instead of sending back default response, tell browser where to go to find out more about this
    #before redirect_to tasks_path
  end

  def edit
    begin
      @task = Task.find(params[:id])
    rescue
      redirect_to tasks_path, flash: {error: "Could not find task with id: #{@task_id}"}
    end
  end

  def update
    begin
      @task = Task.find(params[:id])
    rescue
      redirect_to tasks_path
      return
    end
    # book.update(book_params)
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)
    unless task
      head :not_found
      return
    end
    task.destroy
    redirect_to tasks_path
  end

  def complete
    begin
      task = Task.find(params[:id])
      task.complete
      redirect_to tasks_path
    rescue
      head :not_found
    end
  end

  def incomplete
    begin
      task = Task.find(params[:id])
      task.incomplete
      redirect_to tasks_path
    rescue
      head :not_found
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_date, :completed)
  end
end

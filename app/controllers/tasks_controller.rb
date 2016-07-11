class TasksController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  http_basic_authenticate_with name: "user", password: "secret", except: [:index, :show]

  def index
    @tasks = Task.all.sort_by{|t| t.priority}
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.priority = Task.all.count
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def reorder
    reorder = params[:reorder]
    reorder.each_with_index {|id, i|
      currTask = Task.find(id)
      currTask.priority = i
      currTask.save
    }
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:title, :text, :due_date, :priority)
  end
end

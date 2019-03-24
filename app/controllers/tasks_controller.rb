class TasksController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def show
    @task = current_user.tasks.find(prams[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(prams[:id])
  end

  def update
    task = current_user.tasks.find(prams[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(prams[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}を削除しました。」"
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{task.name}」を登録しました。"
    else
      render :new
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :description)
    end
end

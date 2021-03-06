class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]
  before_action :correct_user, only: [:show,:edit,:update, :destroy]
  before_action :require_user_logged_in, only: [:new, :create]

  def index
    if logged_in?
      @user = current_user
      # @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task が投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
     flash[:success] = 'Task が削除されました。'
     redirect_to root_url
  end

  private

  def set_task
    @task=Task.find(params[:id])
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content,:status)
  end
end
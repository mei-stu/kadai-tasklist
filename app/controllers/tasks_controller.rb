class TasksController < ApplicationController
  # 各アクション前にログイン確認
  before_action :require_user_logged_in
  # DRY用
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    # ユーザ毎に表示内容を分ける
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      #ページネーション用に追記：@pagy, ~ pagy(~)
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))  #items: は1ページに表示するアイテム数
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    # ユーザ毎に処理を分ける
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Task が正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が更新されませんでした'
      render :new
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  private
  
  # DRY：何度も書く処理は関数にしておく。
  def set_task
    @task = Task.find(params[:id])
  end
  
  #Strong parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
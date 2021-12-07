class UsersController < ApplicationController
  
  # ユーザ作成用
  def new
    @user = User.new
  end
  
  # ユーザ登録処理
  def create
    # 登録処理なので入力された値をそのまま使うのはNG。Strong Parameter使う。
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end

class SessionsController < ApplicationController
  
  # 対応するModel（テーブル）がない為、受け取って引き渡すデータがない = コード不要
  # デフォルト処理として、render :new が実行され new.html.erb(view)が呼び出される。
  def new
  end
  
  # ログイン処理
  def create
    # scope を設定していたので、scopeから値を取り出す
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  # ログアウト処理
  def destroy
    # session情報を消すことでログイン状態を維持できなくなる = ログアウト
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  # ログイン判定
  def login(email, password)
    # フォームに入力されたのと同じアドレスのユーザレコードを@userに取り出す
    @user = User.find_by(email: email)
    
    # ユーザレコードが存在する && パスワード認証が通る
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
  
end

class ApplicationController < ActionController::Base
  # Helper使う用
  include SessionsHelper
  
  # ページネーション用
  include Pagy::Backend
  
  private
  
  # アクション前のログイン確認用
  def require_user_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end
  
end

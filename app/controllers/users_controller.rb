class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを作成しました。'
      redirect_to login_url
    else
      #TODO:駄目だった時の処理
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  private
    #TODO:ストロングパラメーター
    def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

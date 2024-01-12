# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  
  before_action :reject_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "guestuserでログインしました。"
  end
  
  def after_sign_in_path_for(resource)
    root_path
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
 protected
    # 会員が退会しているか確認する
    def reject_user
     @user = User.find_by(email: params[:user][:email])
      if @user
      # 　メールで検索したユーザーのパスワードとログイン画面で入力されたパスワードが一致するか
        if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
          redirect_to new_user_registration_path
        else
            flash[:notice] = "項目を入力してください"
        end
      else 
        # モデルに該当するメールがない場合
        flash[:notice] = "該当するユーザーが見つかりません"
      end
    end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

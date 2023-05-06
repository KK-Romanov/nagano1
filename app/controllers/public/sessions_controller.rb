# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]
  
    before_action :customer_state, only: [:create]
    
    # before_action :reject_inactive_user, only: [:create]
    
    def after_sign_in_path_for(resource)
      lot_path 
      # (current_customers.id)
    end
    def after_sign_out_path_for(resource)
       flash[:notice] = "Signed out successfully."
      root_path
    end
    
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  
  def customer_state
  # def reject_inactive_user!
    # if @customer
    @customer = Customer.find_by(email: params[:customer][:email])
     return if !@customer
     if @customer.is_deleted?
        redirect_to new_customer_registration_path
     end
     
     unless @customer.valid_password?(params[:customer][:password])
         
         redirect_to new_customer_session_path
     end
  end
 
end

#  && = *
# 考え方は
# T＝1、F＝0
# or = +  
# 記号= ||

#  xand  
#  xor

# 下記参考
    #   # 退会しているかを判断するメソッド
    #  
    #     ## 【処理内容1】 入力されたemailからアカウントを1件取得
    #     @customer = Customer.find_by(email: params[:customer][:email])
    #     ## アカウントを取得できなかった場合、このメソッドを終了する
    #     return if !@customer
    
    #     ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    #     if @customer.valid_password?(params[:customer][:password])
    #     ## 【処理内容3】
    
    #     #   1」と「2」の処理が真(true)だった場合、そのアカウントのis_deletedカラムに格納されている値を確認し
    #     #     trueだった場合、退会しているのでサインアップ画面に遷移する
    #     #     falseだった場合、退会していないのでそのままcreateアクションを実行させる処理を実行する
    #     end
    #   end
    # end
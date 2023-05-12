class Public::CustomersController < ApplicationController
  def show
       
  end

  def edit
    @customer = current_customer
  end
  

  def update
        @customer = current_customer
        # binding.pry
    if  @customer.update(customer_params)
        redirect_to customers_my_page_path
    else 
        render :edit
    end
  end
  def unsubscribe
    @customer = current_customer 
  end
  # 顧客の退会確認画面
  
  # 顧客の退会処理(ステータスの更新)
  def withdraw
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


   private
  
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :email, 
        :last_name_kana, :first_name_kana, :email, :postal_code, :address, 
        :telephone_number)
    end
      
    def is_matching_login_customer
        customer = Customer.find(params[:id])
      unless customer.id == current_customer.id
      redirect_to root_path
      end
    end
end
  
   
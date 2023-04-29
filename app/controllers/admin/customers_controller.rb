class Admin::CustomersController < ApplicationController
   def index
     @customers = Customer.all
     @customer = current_customer
   end

   def show
     @customer = Customer.find(params[:id])
     @current_customer = current_customer
   end

   def edit
     @customer = current_customer
   end

   def update
        @customer = Customer.find(params[:id])
    if  @customer.update(customer_params)
        redirect_to admin_customer_path(@customer.id)
    else 
        render :edit
    end  
   end

  
   private
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :email, 
        :last_name_kana, :first_name_kana, :email, :postal_code, :address, 
        :telephone_number, :is_delete) 
    end
end

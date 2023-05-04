class Public::AddressesController < ApplicationController
  
    def index
        @address = current_customer.address
        @address = Address.new
        @addresses = Address.all
    end
    
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        if @address.save
        redirect_to addresses_path
        else
        @address = current_customer.address
        render :index
        end
    end
    
     def edit
        @address = Address.find(params[:id])
     end
    
     def update
        @address = Address.find(params[:id])
        if @address.update(address_params)
         redirect_to addresses_path
        else
         render :edit
        end
     end
    
     def destroy
        @address = Address.find(params[:id])
        @address.destroy
        @address = current_customer.address
        # redirect_to _path
     end
  
   private
   def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
   end
end

 
class Public::AddressesController < ApplicationController
  
    def index
        @address = current_customer.addresses
        @address = Address.new
        @addresses = Address.all
    end
    
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        if @address.save
        redirect_to addresses_path
        else
        @address = current_customer.addresses
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
        @addresses.address = Address.find(params[:id])
        @address.destroy
        @addresses = current_customer.addresses
        redirect_to addresses_path
        

     end
   private
   def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
   end
end

 
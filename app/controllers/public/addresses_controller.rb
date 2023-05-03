class Public::AddressesController < ApplicationController
  
    def index
        @addresses = current_customer.addresses
        @addresses = Addresses.new
    end
    
    def create
        @addresses = Addresses.new(addresses_params)
        @addresses.customer_id = current_customer.id
        if @addresses.save
        # redirect_to _path
      else
        @addresses = current_customer.addresses
        render :index
      end
     end
    
     def edit
        @addresses = Addresses.find(params[:id])
     end
    
     def update
        @addresses = Addresses.find(params[:id])
        if @addresses.update(addresses_params)
        # redirect_to _path
        else
         render :edit
       end
     end
    
     def destroy
        @addresses = ShipCity.find(params[:id])
        @addresses.destroy
        @addresses = current_customer.addresses
        # redirect_to _path
     end
  
   private
   def addresses_params
    params.require(:addresses).permit(:customer_id, :name, :postal_code, :address)
   end
end

 
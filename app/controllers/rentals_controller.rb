class RentalsController < ApplicationController
    
    def create
        # byebug
        hsh = rental_params.select{|k| [:user_id, :bike_id].include? k.to_sym}
        bike = Bike.find(hsh[:bike_id])
        user =  User.find(hsh[:user_id])
        
        if (bike.nil? or bike.status == 1 or user.nil?)
            flash[:danger] = @renta.errors.full_messages
            format.html { redirect_to bikes_url }
            format.json { render json: ["User or Bike not found"], status: :unprocessable_entity }
        else
            days = rental_params[:days]
            @rental = Rental.new(hsh)
            @rental.start_date = Time.now
            @rental.end_date = Time.now + days.to_i * 86400 # 24 * 60 * 60 
            @rental.price = bike.price * days.to_i
            
            respond_to do |format|
              if @rental.save
                   flash[:success] = 'Bike has been rented successfully.'
                   format.html { redirect_to bikes_url }
                   format.json { render json: ["Bike has been rented successfully."], status: :unprocessable_entity }
              else
                   flash[:danger] = @rental.errors.full_messages
                   format.html { redirect_to bikes_url }
                   format.json { render json: @rental.errors.full_messages, status: :unprocessable_entity }
              end
            end
        end

    end
    
      # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:user_id, :bike_id, :days)
    end
end

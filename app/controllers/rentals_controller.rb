class RentalsController < ApplicationController
    before_action :set_rental, only: [:show, :edit, :update, :destroy]
    before_action :allow_if_admin, only: [:destroy, :index]
    
    
    def index
        @rentals = Rental.all.order(:start_date, :end_date)
    end
    
    def destroy
    @rental.destroy
    respond_to do |format|
      flash[:success] = 'Booking was successfully deleted.'
      format.html { redirect_to rentals_url }
      format.json { head :no_content }
    end
    end
    
    def create
        # byebug
        hsh = rental_params.select{|k| [:user_id, :bike_id, :start_date, :end_date].include? k.to_sym}
        bike = Bike.find(hsh[:bike_id])
        user =  User.find(hsh[:user_id])

        if (bike.nil? or bike.status != 0 or user.nil?)
            msg = ["Bike not availeble"] if bike.status != 0
            msg = ["User or Bike not found"] if bike.status == 0
            flash[:danger] = msg
            respond_to do |format|
                format.html { redirect_to bike_path(:id=>bike.id) }
                format.json { render json: msg, status: :unprocessable_entity }
            end
        else
            hsh[:price] = 0 #in this way we avoid to dont have a valid rental, since price presence is required
            @rental = Rental.new(hsh)
            if @rental.valid? #check if any required field is not populated
                days = @rental.end_date.to_date - @rental.start_date.to_date
                @rental.price = bike.price * days.to_i 
            end

            respond_to do |format|
              if @rental.save
                   flash[:success] = ['Bike has becen rented successfully.']
                   format.html { redirect_to bike_path(:id=>bike.id) }
                   format.json { render json: ["Bike has been rented successfully."], status: :unprocessable_entity }
              else
                   flash[:danger] = @rental.errors.full_messages
                   format.html { redirect_to bike_path(:id=>bike.id) }
                   format.json { render json: @rental.errors, status: :unprocessable_entity }
              end
            end
        end
    end
    
  private
  
    
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end
      # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:user_id, :bike_id, :start_date, :end_date)
    end
end

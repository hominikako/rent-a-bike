
class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  
  # GET /bikes
  # GET /bikes.json
  def index
    
    if params[:search]
      if  is_admin?
        @bikes = Bike.search(params[:search])
      else
        @bikes = Bike.search(params[:search]).reject {|b| b.status != 0 } 
      end
      @search_for = params[:search]
    else
      # The admin has access to all the bikes when a logged in user (or not logged in) will just be able to see
      # the bikes which status is == 0 (available)
      if  is_admin?
        @bikes = Bike.all
      else
          @bikes = Bike.where(status:0)
      end
      @search_for = nil
    end

  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
    @rental = Rental.new
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
  end

  # GET /bikes/1/edit
  def edit
    
  end

  # POST /bikes
  # POST /bikes.json
  def create
    @bike = Bike.new(bike_params)

    respond_to do |format|
      if @bike.save
        flash[:success] = 'Bike was successfully created.'
        format.html { redirect_to @bike }
        format.json { render :show, status: :created, location: @bike }
      else
        format.html { render :new }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bikes/1
  # PATCH/PUT /bikes/1.json
  def update
    respond_to do |format|
      if @bike.update(bike_params)
        flash[:success] = 'Bike was successfully updated.'
        format.html { render :edit }
        format.json { render :show, status: :ok, location: @bike }
      else
        format.html { render :edit }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @bike.destroy
    respond_to do |format|
      flash[:success] = 'Bike was successfully deleted.'
      format.html { redirect_to bikes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bike
      @bike = Bike.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bike_params
      params.require(:bike).permit(:name, :description, :price, :category, :status)
    end
end

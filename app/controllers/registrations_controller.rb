class RegistrationsController < Devise::RegistrationsController

 #   Overrided method from Devise to obtain the list of rentals for the specific user
  def edit
      @rentals = current_user.rentals.order(:start_date, :end_date)
      super
  end
  
 #   Overrided method from Devise to obtain the list of rentals for the specific user
  def update
      @rentals = current_user.rentals.order(:start_date, :end_date)
      super
  end
  
  private

#   Overrided method from Devise gem to allow custom parameter (name and last_name) when creating user model
  def sign_up_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation)
  end

#   Overrided method from Devise gem to allow custom parameter (name and last_name) when updating user model
  def account_update_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
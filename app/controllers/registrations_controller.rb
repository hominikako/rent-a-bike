class RegistrationsController < Devise::RegistrationsController

  def edit
      @rentals = current_user.rentals.order(:start_date, :end_date)
      super
  end
  
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
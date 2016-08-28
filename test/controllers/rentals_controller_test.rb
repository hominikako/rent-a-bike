require 'test_helper'

class RentalsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  
   setup do
    sign_in User.first
    @rental = rentals(:one)
    @bike = bikes(:one)
    @user = User.first
  end
  
  test "should create a rental" do
    
    assert_difference('Rental.count') do
      post :create, rental: { user_id: @user.id, bike_id: @bike.id, start_date: @rental.start_date, end_date: @rental.end_date }
      assert_redirected_to bike_path(:id=>@bike.id)
    end
  end
  
    test "shouldnt create a rental if another exists in the same dates" do
    
    assert_difference('Rental.count') do
      post :create, rental: { user_id: @user.id, bike_id: @bike.id, start_date: @rental.start_date, end_date: @rental.end_date }
      assert_redirected_to bike_path(:id=>@bike.id)
    end
    
    assert_no_difference('Rental.count') do
      post :create, rental: { user_id: @user.id, bike_id: @bike.id, start_date: @rental.start_date, end_date: @rental.end_date }
      assert_redirected_to bike_path(:id=>@bike.id)
    end
  end
  
end
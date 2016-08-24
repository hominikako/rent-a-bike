require 'test_helper'

class BikesControllerTest < ActionController::TestCase
  setup do
    @bike = bikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bikes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike" do
    assert_difference('Bike.count') do
      post :create, bike: { available: @bike.available, category: @bike.category, colour: @bike.colour, comment: @bike.comment, image: @bike.image, name: @bike.name, status: @bike.status }
    end

    assert_redirected_to bike_path(assigns(:bike))
  end

  test "should show bike" do
    get :show, id: @bike
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike
    assert_response :success
  end

  test "should update bike" do
    patch :update, id: @bike, bike: { available: @bike.available, category: @bike.category, colour: @bike.colour, comment: @bike.comment, image: @bike.image, name: @bike.name, status: @bike.status }
    assert_redirected_to bike_path(assigns(:bike))
  end

  test "should destroy bike" do
    assert_difference('Bike.count', -1) do
      delete :destroy, id: @bike
    end

    assert_redirected_to bikes_path
  end
end

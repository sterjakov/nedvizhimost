# -*- encoding : utf-8 -*-
require 'test_helper'

class HousesControllerTest < ActionController::TestCase
  setup do
    @house = houses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:houses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post :create, house: { address: @house.address, animal: @house.animal, apartment_age: @house.apartment_age, apartment_status: @house.apartment_status, apartment_type: @house.apartment_type, balcon: @house.balcon, bathroom: @house.bathroom, children: @house.children, comission: @house.comission, credit: @house.credit, deposit: @house.deposit, description: @house.description, email: @house.email, fio: @house.fio, floor_apartments: @house.floor_apartments, floor_house: @house.floor_house, furniture_floor: @house.furniture_floor, furniture_kitchen: @house.furniture_kitchen, furniture_status: @house.furniture_status, house_type: @house.house_type, loggia: @house.loggia, metro_station: @house.metro_station, metro_time: @house.metro_time, period: @house.period, phone: @house.phone, price: @house.price, refrigerator: @house.refrigerator, residential_type: @house.residential_type, sell_type: @house.sell_type, square_kitchen: @house.square_kitchen, square_live: @house.square_live, square_main: @house.square_main, tv: @house.tv, washing_mashine: @house.washing_mashine, windows: @house.windows }
    end

    assert_redirected_to house_path(assigns(:house))
  end

  test "should show house" do
    get :show, id: @house
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house
    assert_response :success
  end

  test "should update house" do
    put :update, id: @house, house: { address: @house.address, animal: @house.animal, apartment_age: @house.apartment_age, apartment_status: @house.apartment_status, apartment_type: @house.apartment_type, balcon: @house.balcon, bathroom: @house.bathroom, children: @house.children, comission: @house.comission, credit: @house.credit, deposit: @house.deposit, description: @house.description, email: @house.email, fio: @house.fio, floor_apartments: @house.floor_apartments, floor_house: @house.floor_house, furniture_floor: @house.furniture_floor, furniture_kitchen: @house.furniture_kitchen, furniture_status: @house.furniture_status, house_type: @house.house_type, loggia: @house.loggia, metro_station: @house.metro_station, metro_time: @house.metro_time, period: @house.period, phone: @house.phone, price: @house.price, refrigerator: @house.refrigerator, residential_type: @house.residential_type, sell_type: @house.sell_type, square_kitchen: @house.square_kitchen, square_live: @house.square_live, square_main: @house.square_main, tv: @house.tv, washing_mashine: @house.washing_mashine, windows: @house.windows }
    assert_redirected_to house_path(assigns(:house))
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete :destroy, id: @house
    end

    assert_redirected_to houses_path
  end
end

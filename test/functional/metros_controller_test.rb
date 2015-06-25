# -*- encoding : utf-8 -*-
require 'test_helper'

class MetrosControllerTest < ActionController::TestCase
  setup do
    @metro = metros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metro" do
    assert_difference('Metro.count') do
      post :create, metro: { name: @metro.name }
    end

    assert_redirected_to metro_path(assigns(:metro))
  end

  test "should show metro" do
    get :show, id: @metro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metro
    assert_response :success
  end

  test "should update metro" do
    put :update, id: @metro, metro: { name: @metro.name }
    assert_redirected_to metro_path(assigns(:metro))
  end

  test "should destroy metro" do
    assert_difference('Metro.count', -1) do
      delete :destroy, id: @metro
    end

    assert_redirected_to metros_path
  end
end

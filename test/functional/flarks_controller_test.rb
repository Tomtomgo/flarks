require 'test_helper'

class FlarksControllerTest < ActionController::TestCase
  setup do
    @flark = flarks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flark" do
    assert_difference('Flark.count') do
      post :create, flark: {  }
    end

    assert_redirected_to flark_path(assigns(:flark))
  end

  test "should show flark" do
    get :show, id: @flark
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flark
    assert_response :success
  end

  test "should update flark" do
    put :update, id: @flark, flark: {  }
    assert_redirected_to flark_path(assigns(:flark))
  end

  test "should destroy flark" do
    assert_difference('Flark.count', -1) do
      delete :destroy, id: @flark
    end

    assert_redirected_to flarks_path
  end
end

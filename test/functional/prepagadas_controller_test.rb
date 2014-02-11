require 'test_helper'

class PrepagadasControllerTest < ActionController::TestCase
  setup do
    @prepagada = prepagadas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prepagadas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prepagada" do
    assert_difference('Prepagada.count') do
      post :create, prepagada: { id_odontologo: @prepagada.id_odontologo, prepagada: @prepagada.prepagada }
    end

    assert_redirected_to prepagada_path(assigns(:prepagada))
  end

  test "should show prepagada" do
    get :show, id: @prepagada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prepagada
    assert_response :success
  end

  test "should update prepagada" do
    put :update, id: @prepagada, prepagada: { id_odontologo: @prepagada.id_odontologo, prepagada: @prepagada.prepagada }
    assert_redirected_to prepagada_path(assigns(:prepagada))
  end

  test "should destroy prepagada" do
    assert_difference('Prepagada.count', -1) do
      delete :destroy, id: @prepagada
    end

    assert_redirected_to prepagadas_path
  end
end

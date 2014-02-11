require 'test_helper'

class MedioPagosControllerTest < ActionController::TestCase
  setup do
    @medio_pago = medio_pagos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medio_pagos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medio_pago" do
    assert_difference('MedioPago.count') do
      post :create, medio_pago: { id_odontologo: @medio_pago.id_odontologo, medio_pago: @medio_pago.medio_pago }
    end

    assert_redirected_to medio_pago_path(assigns(:medio_pago))
  end

  test "should show medio_pago" do
    get :show, id: @medio_pago
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medio_pago
    assert_response :success
  end

  test "should update medio_pago" do
    put :update, id: @medio_pago, medio_pago: { id_odontologo: @medio_pago.id_odontologo, medio_pago: @medio_pago.medio_pago }
    assert_redirected_to medio_pago_path(assigns(:medio_pago))
  end

  test "should destroy medio_pago" do
    assert_difference('MedioPago.count', -1) do
      delete :destroy, id: @medio_pago
    end

    assert_redirected_to medio_pagos_path
  end
end

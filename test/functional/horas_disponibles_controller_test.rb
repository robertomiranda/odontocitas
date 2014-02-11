require 'test_helper'

class HorasDisponiblesControllerTest < ActionController::TestCase
  setup do
    @horas_disponible = horas_disponibles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horas_disponibles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horas_disponible" do
    assert_difference('HorasDisponible.count') do
      post :create, horas_disponible: { ano: @horas_disponible.ano, hora: @horas_disponible.hora, mes: @horas_disponible.mes, odontologo_id: @horas_disponible.odontologo_id }
    end

    assert_redirected_to horas_disponible_path(assigns(:horas_disponible))
  end

  test "should show horas_disponible" do
    get :show, id: @horas_disponible
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horas_disponible
    assert_response :success
  end

  test "should update horas_disponible" do
    put :update, id: @horas_disponible, horas_disponible: { ano: @horas_disponible.ano, hora: @horas_disponible.hora, mes: @horas_disponible.mes, odontologo_id: @horas_disponible.odontologo_id }
    assert_redirected_to horas_disponible_path(assigns(:horas_disponible))
  end

  test "should destroy horas_disponible" do
    assert_difference('HorasDisponible.count', -1) do
      delete :destroy, id: @horas_disponible
    end

    assert_redirected_to horas_disponibles_path
  end
end

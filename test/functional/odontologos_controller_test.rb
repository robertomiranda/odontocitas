require 'test_helper'

class OdontologosControllerTest < ActionController::TestCase
  setup do
    @odontologo = odontologos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:odontologos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create odontologo" do
    assert_difference('Odontologo.count') do
      post :create, odontologo: { apellido: @odontologo.apellido, celular: @odontologo.celular, clave: @odontologo.clave, correo: @odontologo.correo, direccion: @odontologo.direccion, especialidad: @odontologo.especialidad, nombre: @odontologo.nombre, telefono: @odontologo.telefono, usuario: @odontologo.usuario }
    end

    assert_redirected_to odontologo_path(assigns(:odontologo))
  end

  test "should show odontologo" do
    get :show, id: @odontologo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @odontologo
    assert_response :success
  end

  test "should update odontologo" do
    put :update, id: @odontologo, odontologo: { apellido: @odontologo.apellido, celular: @odontologo.celular, clave: @odontologo.clave, correo: @odontologo.correo, direccion: @odontologo.direccion, especialidad: @odontologo.especialidad, nombre: @odontologo.nombre, telefono: @odontologo.telefono, usuario: @odontologo.usuario }
    assert_redirected_to odontologo_path(assigns(:odontologo))
  end

  test "should destroy odontologo" do
    assert_difference('Odontologo.count', -1) do
      delete :destroy, id: @odontologo
    end

    assert_redirected_to odontologos_path
  end
end

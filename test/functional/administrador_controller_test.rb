require 'test_helper'

class AdministradorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get odontologos" do
    get :odontologos
    assert_response :success
  end

  test "should get pacientes" do
    get :pacientes
    assert_response :success
  end

end

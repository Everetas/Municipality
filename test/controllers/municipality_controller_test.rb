require 'test_helper'

class MunicipalityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get municipality_index_url
    assert_response :success
  end

end

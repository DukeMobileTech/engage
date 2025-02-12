require "test_helper"

class DataUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @data_upload = data_uploads(:one)
  end

  test "should get index" do
    get data_uploads_url
    assert_response :success
  end

  test "should get new" do
    get new_data_upload_url
    assert_response :success
  end

  test "should create data_upload" do
    assert_difference("DataUpload.count") do
      post data_uploads_url, params: { data_upload: { name: @data_upload.name } }
    end

    assert_redirected_to data_upload_url(DataUpload.last)
  end

  test "should show data_upload" do
    get data_upload_url(@data_upload)
    assert_response :success
  end

  test "should get edit" do
    get edit_data_upload_url(@data_upload)
    assert_response :success
  end

  test "should update data_upload" do
    patch data_upload_url(@data_upload), params: { data_upload: { name: @data_upload.name } }
    assert_redirected_to data_upload_url(@data_upload)
  end

  test "should destroy data_upload" do
    assert_difference("DataUpload.count", -1) do
      delete data_upload_url(@data_upload)
    end

    assert_redirected_to data_uploads_url
  end
end

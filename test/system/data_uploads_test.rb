require "application_system_test_case"

class DataUploadsTest < ApplicationSystemTestCase
  setup do
    @data_upload = data_uploads(:one)
  end

  test "visiting the index" do
    visit data_uploads_url
    assert_selector "h1", text: "Data uploads"
  end

  test "should create data upload" do
    visit data_uploads_url
    click_on "New data upload"

    fill_in "Name", with: @data_upload.name
    click_on "Create Data upload"

    assert_text "Data upload was successfully created"
    click_on "Back"
  end

  test "should update Data upload" do
    visit data_upload_url(@data_upload)
    click_on "Edit this data upload", match: :first

    fill_in "Name", with: @data_upload.name
    click_on "Update Data upload"

    assert_text "Data upload was successfully updated"
    click_on "Back"
  end

  test "should destroy Data upload" do
    visit data_upload_url(@data_upload)
    click_on "Destroy this data upload", match: :first

    assert_text "Data upload was successfully destroyed"
  end
end

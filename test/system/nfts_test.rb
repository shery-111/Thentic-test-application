require "application_system_test_case"

class NftsTest < ApplicationSystemTestCase
  setup do
    @nft = nfts(:one)
  end

  test "visiting the index" do
    visit nfts_url
    assert_selector "h1", text: "Nfts"
  end

  test "should create nft" do
    visit nfts_url
    click_on "New nft"

    click_on "Create Nft"

    assert_text "Nft was successfully created"
    click_on "Back"
  end

  test "should update Nft" do
    visit nft_url(@nft)
    click_on "Edit this nft", match: :first

    click_on "Update Nft"

    assert_text "Nft was successfully updated"
    click_on "Back"
  end

  test "should destroy Nft" do
    visit nft_url(@nft)
    click_on "Destroy this nft", match: :first

    assert_text "Nft was successfully destroyed"
  end
end

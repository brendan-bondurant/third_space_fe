require "rails_helper"

RSpec.describe "Show Location Details of Space", type: :feature do 
  before :each do
    user_login_data
    user_select_loc_data
    click_link "here"

    fill_in :name, with: "Five Watt"
    fill_in :city, with: "Minneapolis"
    click_button "submit"

    within("#location_result-5pWHnKN3_AIrXiyyqZ74pw") do
      click_link "Five Watt"
    end
  end

  describe "General Third Space details displayed" do 
    it "lists the the general details including name, open status, tags, description, address, and hours" do
      expect(page).to have_content("Five Watt Coffee")
      expect(page).to have_content("$$")
      expect(page).to have_content("Rating: 4.5")
      expect(page).to have_content("Coffee & Tea")
      expect(page).to have_content("Address: 3745 Nicollet Ave S, Minneapolis, MN 55409")
      expect(page).to have_link("Create a Third Space", href: new_third_space_path, class: "rounded-button")
    end
  end
end
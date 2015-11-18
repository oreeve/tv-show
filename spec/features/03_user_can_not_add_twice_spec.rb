require 'spec_helper'

# As an organized TV fanatic
# I want to receive an error message if I try to add the same show twice
# So that I don't have duplicate entries

# Acceptance Criteria:
# [] If the title is the same as a show that I've already added, the details are not saved to the csv
# [] If the title is the same as a show that I've already added, I will be shown an error that says "The show has already been added".
# [] If the details of the show are not saved, I will remain on the new form page

feature "user tries to add a show already on the list and receives error message" do

  scenario "try to add show that already exists and receive error message" do
    visit "/TVShows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "genre"

    click_button "Add TV Show"

    visit "/TVShows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "genre"

    click_button "Add TV Show"

    expect(page).to have_content "This show already exists"

  end
end

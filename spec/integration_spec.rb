require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the root path', {:type => :feature}) do
  it('renders the index page') do
    visit('/')
    expect(page).to have_content("Add New Stylist")
    expect(page).to have_content("View Stylists")
  end

  it('renders the new stylist form') do
    visit('/')
    click_link("Add New Stylist")
    expect(page).to have_content("Name")
    expect(page).to have_content("Phone Number")
    expect(page).to have_content("Email Address")
  end

  it('renders the new client form') do
    visit('/')
    click_link("Add New Client")
    expect(page).to have_content("Name")
    expect(page).to have_content("Phone Number")
    expect(page).to have_content("Email Address")
  end
end

describe('the stylist path', {:type => :feature}) do
  it('creates a new stylist') do
    visit('/stylists/new')
    fill_in("name", with: "James Williams")
    fill_in("phone", with: "234-432-1234")
    fill_in("email", with: "james@gmail.com")
    click_button("Add Stylist")
    expect(page).to have_content("James Williams")
  end

  it('tells you if no stylists have been added') do
    visit('/stylists')
    expect(page).to have_content('No stylists have been added')
  end
end

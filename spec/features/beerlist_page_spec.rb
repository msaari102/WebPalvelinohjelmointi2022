require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end
  
    Capybara.javascript_driver = :chrome
    WebMock.allow_net_connect!
    #WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    #find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "has beers in right order", :js => true do
    visit beerlist_path
    save_and_open_page
    rows = find('#beertable').all('.tablerow')
    expect(rows[0]).to have_content "Fastenbier"
    expect(rows[1]).to have_content "Lechte Weisse"
    expect(rows[2]).to have_content "Nikolai"
  end

  it "has beers in right order after sorting by style", :js => true do
    visit beerlist_path
    save_and_open_page
    find_by_id('style').click
    rows = find('#beertable').all('.tablerow')
    expect(rows[0]).to have_content "Lager"
    expect(rows[1]).to have_content "Rauchbier"
    expect(rows[2]).to have_content "Weizen"
  end

  it "has beers in right order after sorting by brewery", :js => true do
    visit beerlist_path
    save_and_open_page
    find_by_id('brewery').click
    rows = find('#beertable').all('.tablerow')
    expect(rows[0]).to have_content "Ayinger"
    expect(rows[1]).to have_content "Koff"
    expect(rows[2]).to have_content "Schlenkerla"
  end

  
end
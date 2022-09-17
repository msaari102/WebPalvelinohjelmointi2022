require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(WeatherApi).to receive(:places_in).with("kumpula").and_return(
      Weather.new( temperature: "12", weather_icons: [], wind_speed: "1", wind_dir: "N" )
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if three are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ),
        Place.new( name: "Vipuvarsi", id: 2 ),
        Place.new( name: "Ruusu", id: 3 ) ]
    )
    allow(WeatherApi).to receive(:places_in).with("kumpula").and_return(
      Weather.new( temperature: "12", weather_icons: [], wind_speed: "1", wind_dir: "N" )
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Vipuvarsi"
    expect(page).to have_content "Ruusu"
  end

  it "if none is returned by the API, error message is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )
    allow(WeatherApi).to receive(:places_in).with("kumpula").and_return(
      Weather.new( temperature: "12", weather_icons: [], wind_speed: "1", wind_dir: "N" )
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end
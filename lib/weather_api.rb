# http://api.weatherstack.com/current?access_key=' + api_key + '&query=' + city

class WeatherApi
  def self.places_in(city)
    city = city.downcase
    get_weather_in(city)
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    return nil if response["current"].nil?

    Weather.new(response["current"])
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'WEATHER_APIKEY env variable not defined' if ENV['WEATHER_APIKEY'].nil?

    ENV.fetch('WEATHER_APIKEY')
  end

  # def self.key
  #  export WEATHER_APIKEY="7c978be4aa6c3baccc6f34221846af2f"
  # end
end

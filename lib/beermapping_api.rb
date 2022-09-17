class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.weeks) { get_places_in(city) }
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'BEERMAPPING_APIKEY env variable not defined' if ENV['BEERMAPPING_APIKEY'].nil?

    ENV.fetch('BEERMAPPING_APIKEY')
  end

  # def self.key
  #  export BEERMAPPING_APIKEY="048d0f8d3409c5ab7c0c6ef4ad1f62de"
  # BEERMAPPING_APIKEY="048d0f8d3409c5ab7c0c6ef4ad1f62de" WEATHER_APIKEY="7c978be4aa6c3baccc6f34221846af2f" rails s
  # end
end

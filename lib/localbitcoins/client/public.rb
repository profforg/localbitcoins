require 'open-uri'
module LocalBitcoins
  module Public
    ROOT = 'https://localbitcoins.com'

    # Valid API endpoints include:
    # /buy-bitcoins-online/{countrycode:2}/{country_name}/{payment_method}/.json
    # /buy-bitcoins-online/{countrycode:2}/{country_name}/.json
    # /buy-bitcoins-online/{currency:3}/{payment_method}/.json
    # /buy-bitcoins-online/{currency:3}/.json
    # /buy-bitcoins-online/{payment_method}/.json
    # /buy-bitcoins-online/.json
    #
    # NOTE: countrycode must be 2 characters and currency must be 3 characters
    #
    def online_buy_ads_lookup(params={})
      params.each_key do |k|
          params[k] << '/'
      end
      __execute "#{ROOT}/buy-bitcoins-online/#{params[:countrycode]}#{params[:currency]}#{params[:country_name]}#{params[:payment_method]}.json"
    end

    # NOTE: Same format as online_buy_ads_lookup, but buy is replaced with sell
    #
    def online_sell_ads_lookup(params={})
      params.each do |k,v|
          params[k]=v<<'/' unless v.nil?
      end
      __execute "#{ROOT}/sell-bitcoins-online/#{params[:countrycode]}#{params[:currency]}#{params[:country_name]}#{params[:payment_method]}.json"
    end

    # - Required fields -
    # location_id               - id for location found using places method
    # location_slug             - slug name for location found using places method
    #
    # - Optional fields -
    # lat                       - latitude of location [float]
    # lon                       - longitude of location [float]
    #
    def local_buy_ad(params={})
      __execute "#{ROOT}/buy-bitcoins-with-cash/#{params[:location_id]}/#{params[:location_slug].downcase}/.json?lat=#{params[:lat]}&lon=#{params[:lon]}"
    end

    # NOTE: Same format as local_buy_ad, but buy is replaced with sell
    #
    def local_sell_ad(params={})
      __execute "#{ROOT}/sell-bitcoins-for-cash/#{params[:location_id]}/#{params[:location_slug].downcase}/.json?lat=#{params[:lat]}&lon=#{params[:lon]}"
    end

    def payment_methods(countrycode=nil)
      countrycode << '/' unless countrycode.nil?
      __execute "#{ROOT}/api/payment_methods/#{countrycode}", data: true
    end

    def currencies
      __execute "#{ROOT}/api/currencies/", data: true
    end

    def countrycodes
      __execute "#{ROOT}/api/countrycodes/", data: true
    end

    # - Required fields -
    # lat                       - latitude of location [float]
    # lon                       - longitude of location [float]
    #
    # - Optional fields -
    # countrycode               - 2 letter countrycode
    # location_string           - location name in string form
    #
    def places(params={})
      __execute "#{ROOT}/api/places/?#{params.to_query}", data: true
    end

    private

    def __execute(uri, data: false)
      response = RestClient.get(uri)
      return unless response.code == 200
      response = Hashie::Mash.new(JSON.parse(response.body))
      data ? response.data : response
    end
  end
end

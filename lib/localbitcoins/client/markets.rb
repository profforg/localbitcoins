require 'open-uri'
module LocalBitcoins
  module Markets

    # LocalBitcoins.com provides public trade data available for market chart services and tickers
    # The API is in bitcoincharts.com format
    # Currently supported currencies:
    # ARS, AUD, BRL, CAD, CHF, CZK, DKK, EUR, GBP, HKD, ILS, INR, MXN, NOK, NZD, PLN, RUB, SEK, SGD, THB, USD, ZAR

    ROOT = 'https://localbitcoins.com'

    def ticker
      __execute "#{ROOT}/bitcoinaverage/ticker-all-currencies/"
    end

    def trades(currency, last_tid=nil)
      __execute "#{ROOT}/bitcoincharts/#{currency}/trades.json?since=#{last_tid}"
    end

    def orderbook(currency)
      __execute "#{ROOT}/bitcoincharts/#{currency}/orderbook.json"
    end
  end
end

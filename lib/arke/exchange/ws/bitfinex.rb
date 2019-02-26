# frozen_string_literal: true

require 'order'

module Arke::Exchange::WS
  class BitfinexWebsocket < Base

    def initialize(config, strategy)
      super
    end

    def call(action)
      super
    end

    def start_listener
      @ws_listener = Thread.new { subscribe_to_ws }
    end

    def stop_listener
      Thread.exit
    end

    # to define
    def post_new_order(_params); end

    def process_data(data)
      order = parse_ws_data(data)
      push(':cancel_order', order) if order.price.zero?
      order_exists?(data) ? push(':update_order', order) : push(':create_order', order)
    end

    def push(action, data)
      super
    end

    private

    def parse_ws_data(data)
      data[2].positive? ? build_buy_order(data) : build_sell_order(data)
    end

    def build_buy_order(data)
      Arke::Order.new(
        data[0],
        @strategy.market,
        data[1],
        data[2],
        :buy
      )
    end

    def build_sell_order(data)
      Arke::Order.new(
        data[0],
        @strategy.market,
        data[1],
        - data[2],
        :sell
      )
    end

    def order_exists?(_data)
      # to be defined
      # @strategy.bitfinex_orderbook.contains? data
      false
    end
  end
end

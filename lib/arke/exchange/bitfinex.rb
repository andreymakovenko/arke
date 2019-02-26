# frozen_string_literal: true

require 'order'

module Arke::Exchange
  class Bitfinex < Base
    def initialize(config, strategy)
      super
    end

    def call(action)
      # we can use separate websocket worker as event emitter
      # it solves a problem with queue.pop, websocket will push messages
      # exchange handles parsing and subscription logic
      Arke::Log.debug 'Bitfinex processes action'
      Arke::Log.debug action.inspect

      if action.type == :websocket
        # parsing and sending to strategy
        # @strategy.push_order
      end
    end

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

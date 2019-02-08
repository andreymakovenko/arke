# encoding: UTF-8
# frozen_string_literal: true

require 'binance'
require 'pp'
require 'logger'
require 'faye/websocket'
require 'eventmachine'
require 'json'

require_relative '../order'
require_relative '../price_level'
require_relative '../orderbook'

module Arke::Exchange
  class BinanceSocket

    def initialize
      @client = Binance::Client::WebSocket.new
      @last_update_id = 0
      @log = Logger.new(STDOUT)
      @url = "wss://stream.binance.com:9443"
      @map = {}
    end

    def methods
      {
        open:    proc { |e| on_open e },
        message: proc { |e| process_message JSON.parse(e.data) },
        error:   proc { |e| puts e },
        close:   proc { puts 'closed' },
      }
    end

    # def process_message(data)
    #   return if data['U'] < @last_update_id
    #   pp 'Binance asks:'
    #   data['a'].each do |elem|
    #     next if elem[1].to_f == 0.0
    #     pp elem.flatten
    #   end

    #   pp 'Binance bids:'
    #   data['b'].each do |elem|
    #     next if elem[1].to_f == 0.0
    #     pp elem.flatten
    #   end
    #   @last_update_id = data['u']
    # end

    def handle_subscribed_event(msg)
      @map[msg['chanId']] = {
        info: msg,
        book: Arke::Orderbook.new(msg['pair'])
      }
    end

    def on_open(e)
      @log.info 'Open event'
      sub = {
        event: "subscribe",
        channel: "book",
        pair: "BTCUSDT",
        prec: "R0"
      }

      EM.next_tick {
        @ws.send(JSON.generate(sub))
      }
    end


    def process_message(msg)
      if msg.kind_of?(Array)
        process_channel_message(msg)
      elsif msg.kind_of?(Hash)
        process_event_message(msg)
      end
    end

    def process_channel_message(msg)
      book = @map[msg[0]][:book]
      data = msg[1]
      if data.length == 3
        update_order(book, data)
      elsif data.length > 3
        data.each { |order|
          update_order(book, order)
        }
      end
      @book = book
    end

    def update_order(book, data)
      id, price, amount = data
      if price == 0
        book.remove(id)
      else
        book.add(Arke::Order.new(id, 'ETHUSD', price, amount))
      end
    end

    def process_event_message(msg)
      case msg['event']
      when 'auth'
      when 'subscribed'
        handle_subscribed_event(msg)
      when 'unsubscribed'
      when 'info'
      when 'conf'
      when 'error'
        @log.info "Event: #{msg['event']} ignored"
      end
    end


    def start
      EM.run do
        # @client.agg_trade symbol: 'XRPETH', methods: methods
        # @client.kline symbol: 'XRPETH', interval: '1m', methods: methods
        @client.diff_depth symbol: 'BTCUSDT', methods: methods
      end
    end
  end
end

# frozen_string_literal: true

require 'arke'
require 'spec_helper'

describe Arke::Exchange::Bitfinex do
  let(:config) do
    {
      'driver' => 'rubykube',
      'host' => 'http://www.devkube.com',
      'key' => @authorized_api_key,
      'secret' => SecureRandom.hex
    }
  end
  let(:strategy) { Arke::Strategy::Copy.new({'market' => 'ethusd'}) }
  let(:bitfinex) { Arke::Exchange::Bitfinex.new(config, strategy) }

  context 'websocket messages processing' do
    # contains 3 orders with same id to test update and cancel actions when orderbook will be merged
    let(:ws_data) do
      [
        [22496904977, 125.2, -102.98022124],
        [22496903051, 125.19, 0.2],
        [22496903051, 125.19, 0.1],
        [22496903051, 125.19, 0.0]
      ]
    end

    context 'sell order ws message processing' do
      let(:process_first_message) { bitfinex.process_data(ws_data.first) }

      it 'sends Arke::Action to strategy' do
        expect(strategy).to receive(:push).with(Arke::Action)
        process_first_message
      end

      it 'creates Arke::Action with Arke::Order as params' do
        expect(process_first_message.params).to be_an_instance_of(Arke::Order)
      end

      it 'Arke::Action comes with correct params' do
        expect(process_first_message.params.market).to eq('ethusd')
        expect(process_first_message.params.side).to eq(:sell)
        expect(process_first_message.params.amount).to eq(ws_data.first.last * -1)
        expect(process_first_message.params.id).to eq(ws_data.first.first)
        expect(process_first_message.params.price).to eq(ws_data.first[1])
      end
    end

    context 'buy order ws message processing' do
      let(:process_second_message) { bitfinex.process_data(ws_data[1]) }

      it 'sends Arke::Action to strategy' do
        expect(strategy).to receive(:push).with(Arke::Action)
        process_second_message
      end

      it 'creates Arke::Action with Arke::Order as params' do
        expect(process_second_message.params).to be_an_instance_of(Arke::Order)
      end

      it 'Arke::Action comes with correct params' do
        expect(process_second_message.params.market).to eq('ethusd')
        expect(process_second_message.params.side).to eq(:buy)
        expect(process_second_message.params.amount).to eq(ws_data[1].last)
        expect(process_second_message.params.id).to eq(ws_data[1].first)
        expect(process_second_message.params.price).to eq(ws_data[1][1])
      end
    end
  end
end

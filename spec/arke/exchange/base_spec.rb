# frozen_string_literal: true

require 'spec_helper'
require 'securerandom'

describe Arke::Exchange::Base do
  context 'action push' do
    let(:config) do
      {
        'driver' => 'rubykube',
        'host' => 'http://www.devkube.com',
        'key' => @authorized_api_key,
        'secret' => SecureRandom.hex
      }
    end
    let(:strategy) { Arke::Strategy::Base.new(config) }
    let(:exchange) { Arke::Exchange::Base.new(config, strategy) }
    let(:action) { :shutdown }
    let(:params) { [] }

    it 'pushes action with params' do
      expect(strategy).to receive(:push).with(Arke::Action)
      exchange.push(action, params)
    end
  end
end

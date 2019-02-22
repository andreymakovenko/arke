# frozen_string_literal: true

require 'spec_helper'
require 'arke/exchange/base'

describe Arke::Exchange::Base do
  context 'action push' do
    let(:strategy) { Arke::Strategy::Base.new }
    let(:exchange) { Arke::Exchange::Base.new(strategy) }
    let(:action) { 'SHUTDOWN' }
    let(:params) { [] }

    it 'pushes action with params' do
      expect(strategy).to receive(:push).with(Arke::Action)
      exchange.push(action, params)
    end
  end
end

# frozen_string_literal: true

module Arke::Exchange
  class Base
    def initialize(config, strategy)
      @strategy = strategy
    end

    def call(action)
    end

    def push(action, data)
      @strategy.push(Arke::Action.new(action, data))
    end
  end
end

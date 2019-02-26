# frozen_string_literal: true

module Arke::Exchange::WS
  class Base
    attr_reader :config, :strategy, :ws_listener

    class UnknownActionError < StandardError; end

    def initialize(config, strategy)
      @config = config
      @strategy = strategy
      @ws_listener = nil
    end

    def call(action)
      case action.type
      when :start
        start_listener
      when :shutdown
        stop_listener
      when :create_order
        post_new_order(action.params)
      else
        raise UnknownActionError
      end
    end
  end
end

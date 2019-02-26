# frozen_string_literal: true

require 'exchange'
require 'action'

module Arke::Strategy
  class Base
    def initialize(config)
      @sources = []
      @target = nil
      @order_queue = Queue.new
    end

    def call
    end

    def add_source_worker(worker)
      @sources.push(worker)
    end

    def set_target_worker(worker)
      @target = worker
    end

    # place for logic to be added when we finish Worker class
    def push(action);
      action
    end
  end
end

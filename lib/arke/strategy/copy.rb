require 'action'

module Arke::Strategy
  class Copy < Base
    attr_accessor :market

    def initialize(config)
      super
      @market = config['market']
    end

    def call
      # So, here we need access to workers, at least to target worker
      Arke::Log.debug 'Copy startegy called'
      puts
      action = Arke::Action.new(:echo_action, { 'hello' => 'world' })
      @target.push(action)
    end

    def push(action)
      super
    end
  end
end

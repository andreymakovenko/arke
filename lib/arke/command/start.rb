require 'exchange/bitfinex'

module Arke
  module Command
    class Start < Clamp::Command
      def execute
        EM.run do
          bf = Arke::Exchange::Bitfinex.new
          bf.start

          EM.add_timer(5) { binding.pry }

          trap("INT") { EM.stop }
          trap("TERM") { EM.stop }
        end
      end
    end
  end
end

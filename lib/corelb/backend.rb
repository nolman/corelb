module Corelb
  class Backend
    attr_reader :ip_port

    def initialize(ip_port)
      @ip_port = ip_port
    end
  end
end

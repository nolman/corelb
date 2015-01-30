module Corelb
  class HostProvider
    attr_reader :hostname
    attr_reader :key
    attr_reader :backends

    def initialize(options)
      @hostname = options['hostname']
      @key = options['key']
      @backends = options['backends'].map {|b| Backend.new(b)} if options['backends']
    end
  end
end

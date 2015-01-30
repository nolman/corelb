module Corelb
  class Entry
    attr_reader :key
    attr_reader :port
    attr_reader :protocol
    attr_reader :cert

    # TCP Based Services
    attr_reader :backends

    # HTTP Based Services
    attr_reader :host_providers
    attr_reader :default_provider_key

    def initialize(options)
      @key = options['key']
      @port = options['port']
      @protocol = options['protocol']
      @cert = options['cert']
      @backends = options['backends'].map {|b| Backend.new(b)} if options['backends']
      @host_providers = options['host_providers'].map {|h| HostProvider.new(h)} if options['host_providers']
      @default_provider_key = options['default_provider_key']
    end
  end

  def self.from_params(raw_entries)
    raw_entry.map do |raw_entry|
      Entry.new(raw_entry)
    end
  end
end

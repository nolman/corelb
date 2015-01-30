require 'erb'
require 'ostruct'

module Corelb
  module Writers
    class HaProxy
      TEMPLATE = File.read(File.expand_path('../../templates/ha_proxy.conf.erb', __FILE__))

      attr_reader :conf_location, :reload_command

      def initialize(conf_location, reload_command)
        @conf_location = conf_location
        @reload_command = reload_command
        @entries = {}
      end

      def update_entry(entry)
        @entries[entry.key] = entry
      end

      def remove_entry(entry)
        @entries.delete(entry.key)
      end

      def generate_bindings
        OpenStruct.new(entries: @entries.values)
      end

      def generate_conf
        puts ERB.new(TEMPLATE, nil, '-').result(generate_bindings.instance_eval { binding })
        ERB.new(TEMPLATE, nil, '-').result(generate_bindings.instance_eval { binding })
      end

      def write_conf
        File.open(@conf_location, 'w') do |f|
          f.write(generate_conf)
        end
      end

      def reload
      end
    end
  end
end

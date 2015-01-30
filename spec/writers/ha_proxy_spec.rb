require 'spec_helper'

describe Corelb::Writers::HaProxy do
  let(:expected_conf) { File.read(File.expand_path('../../fixtures/expected_ha_proxy.conf', __FILE__)) }
  let(:only_tcp_conf) { File.read(File.expand_path('../../fixtures/only_tcp_conf.conf', __FILE__)) }
  let(:conf_path) { File.expand_path('../../../tmp/ha_proxy.conf', __FILE__) }
  let(:reload_command) { '' }
  let(:pem_key) { File.read(File.expand_path('../../fixtures/cert.pem')) }

  subject { Corelb::Writers::HaProxy.new(conf_path, reload_command) }

  let(:tcp_entry) {
    #Entry Key Values
    #TCP: protocol_org_app_instance_type
    #http: http-in
    #https: https-in
    #
    #HostProvider Key Values
    # fqdn:port
    Entry.new({
      'key' => 'tcp_hello_world_ssh',
      'port' => 22,
      'protocol' => 'tcp',
      'backends' => [
        '192.168.0.1:8000',
        '192.168.0.1:8001',
      ]
    })
  }
  let(:http_entry) {
    Entry.new({
      'key' => 'http-in',
      'port' => 80,
      'protocol' => 'http',
      'default_provider_key' => 'hello.world.com:80',
      'host_providers' => [
        {
          'hostname' => 'hello.world.com',
          'key' => 'hello.world.com:80',
          'backends' => [
            '192.168.0.2:8002',
            '192.168.0.3:8004',
          ]
        },
        {
          'hostname' => 'bar.world.com',
          'key' => 'bar-world-com:80',
          'backends' => [
            '192.168.0.22:2002',
            '192.168.0.13:2004',
          ]
        },
      ]
    })
  }
  let(:entries) { [tcp_entry, http_entry] }

  describe '#update_entry' do
    it 'generates the expected conf' do
      entries.each do |entry|
        subject.update_entry(entry)
      end
      expect(subject.generate_conf).to eq(expected_conf)
    end
  end

  describe '#remove_entry' do
    it 'generates the expected conf' do
      entries.each do |entry|
        subject.update_entry(entry)
      end
      subject.remove_entry(entries[1])
      expect(subject.generate_conf).to eq(only_tcp_conf)
    end
  end
end

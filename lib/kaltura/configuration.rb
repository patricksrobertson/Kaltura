require 'singleton'

module Kaltura
  class Configuration
    include Singleton

    @@defaults = {
      :partner_id => 'PARTNER_ID',
      :administrator_secret => 'ADMINISTRATOR_SECRET',
      :service_url => 'http://kaltura.com'
    }

    attr_accessor :administrator_secret, :partner_id, :service_url

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end
  end

  def self.config
    Configuration.instance
  end

  def self.configure
    yield config
  end
end

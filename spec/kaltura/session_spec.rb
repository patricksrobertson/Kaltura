require 'spec_helper'

describe Kaltura::Session do
  use_vcr_cassette

  context "starting a session" do
    describe "should begin a session with proper credentials." do
      before do
        Kaltura.configure do |config|
          config.partner_id = 1
          config.administrator_secret = 'superdupersecret'
          config.service_url = 'http://www.kaltura.com'
        end
        @session = Kaltura::Session.start
      end

       it { @session.result.should be_an_instance_of String }
       it { Kaltura::Session.kaltura_session.should eq(@session.result) }
    end
    describe "should not begin a session with invalid credentials." do
      before do
        Kaltura.configure { |config| config.partner_id = 2 }
      end

      it { lambda {Kaltura::Session.start}.should raise_error Kaltura::KalturaError }
    end
  end
end

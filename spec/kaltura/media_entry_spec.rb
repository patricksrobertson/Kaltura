require 'spec_helper'

describe Kaltura::MediaEntry do
  use_vcr_cassette

  before do
    Kaltura.configure do |config|
      config.partner_id = 1
      config.administrator_secret = 'superdupersecret'
      config.service_url = 'http://www.kaltura.com'
    end
  end

  context "retrieving an entry" do
    describe "should be able to retrieve an existing video." do
      before do
        @entry = Kaltura::MediaEntry.get('0_2vk9wpn9')
      end

      it { @entry.should be_an_instance_of Kaltura::MediaEntry }
      it { @entry.id.should eql('0_2vk9wpn9') }
    end

    describe "should raise an error retrieving a non-existant video." do
      it { lambda { Kaltura::MediaEntry.get('waffleman') }.should raise_error Kaltura::KalturaError }
    end
  end

  context "retrieving multiple entries" do
    describe "should be able to retrieve all videos." do
      it { lambda { Kaltura::MediaEntry.list }.should_not raise_error }
    end

    describe "retrieving without paramters." do
      before do
        @entries_list = Kaltura::MediaEntry.list
      end

      it { @entries_list.should be_an_instance_of Array }
      it { @entries_list.first.should be_an_instance_of Kaltura::MediaEntry }
      it { @entries_list.should have_at_least(1).things }
      it { @entries_list.should have_at_most(30).things }
    end

    context "retrieve another page." do
      describe "should be able to retrieve another page." do
        before do
          @options = { :pager => { :pageIndex => 2} }
        end

        it { lambda { Kaltura::MediaEntry.list(@options) }.should_not raise_error }
      end

      describe "shouldn't be the same as the first page" do
        before do
          @first_page = Kaltura::MediaEntry.list
          @second_page = Kaltura::MediaEntry.list(:pager => {:pageIndex => 2})
        end

        it { @fist_page.should_not eql(@second_page) } 
      end
    end

    context "filtering" do
      describe "should be able to filter." do
        before do
          @options = { :filter => { :orderBy => "%2BcreatedAt" } }
        end

        it { lambda { Kaltura::MediaEntry.list(@options) }.should_not raise_error }
      end

      describe "filtering should work." do
        before do
          @first_page = Kaltura::MediaEntry.list(:filter => { :orderBy => "-createdAt" })
          @second_page = Kaltura::MediaEntry.list(:filter => { :orderBy => "%2BcreatedAt" })
        end

        it { @first_page.should_not eql(@second_page) }
      end
    end

    context "updating an entry" do
      before do
        @entry = Kaltura::MediaEntry.get('0_2vk9wpn9')
      end

      describe "should not raise an error" do
        it { lambda { @entry.update(:category => "") }.should_not raise_error }
      end
      describe "should be able to update existing entry." do
        it "should update the tags wihtout an error" do
          @entry.update(:tags => "harvard, youtube").should be_an_instance_of Kaltura::MediaEntry
        end
        it "should persist the change in the original media entry." do
          @entry.update(:tags => "Youtube, harvard")
          @entry.tags.should eq("Youtube, harvard")
        end
      end
    end
  end
end

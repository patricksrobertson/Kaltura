module Kaltura
  class MediaEntry < DelegateClass(Hashie::Mash)
    extend ClientResource

    def update(options={})
      update_options = { :entryId => self.id , :mediaEntry => options }
      Kaltura::MediaEntry.fetch('media', 'update', update_options).first
      self.merge!(options)

      self
    end

    def self.get(id,version=nil)
      fetch('media', 'get', {:entryId => id, :version => version}).first
    end

    def self.list(options={})
      fetch('media', 'list', options).first.objects.item.map { |item| Kaltura::MediaEntry.new(item) }
    end

    private

    def self._ks_required?
      true
    end
  end
end

module Kaltura
  module ClientResource

    def fetch(service, action, options = {})
      _kickstart_session!

      response = HTTParty.get(url, 
                              :query => _standard_options(service, action, options), 
                              :format => :xml)
      _verify_http_code!(response, 200) { raise FetchError, "Fetch failed, HTTP error: #{response.code}" }
      mashes = _mashes_from_response(response)
      return_mash = mashes.map { |m| new(m) }

      _verify_kaltura_error!(return_mash)
    end

    def post(service, action, options = {})
      options[:service] = service
      options[:action] = action
      response = HTTParty.post(url, :body => options, :format => :xml)
      _verify!(response, 201) { raise CreateError, "Create failed, HTTP error: #{response.code}" }
    end

    def url
      "#{Kaltura.config.service_url}/api_v3/"
    end

    private

    def _standard_options(service, action, options ={})
      options.merge!(:ks => Kaltura::Session.kaltura_session, :action => action, :service => service)
    end

    def _kickstart_session!
      if _ks_required? && Kaltura::Session.kaltura_session == nil
        Kaltura::Session.start
      end
    end

    def _ks_required?
      false
    end

    def _verify_http_code!(response, code, &block)
      block.call unless response.code == code
    end

    def _verify_kaltura_error!(response_mash)
      if response_mash.first.respond_to?(:error)
        raise KalturaError, "Code: #{response_mash.first.error.code}, Message: #{response_mash.first.error.message}"
      end
      response_mash
    end

    def _mashes_from_response(response)
      return [] unless response.respond_to?(:to_a)
      flattened_response = response.to_a.flatten
      flattened_response.keep_if { |r| r.is_a?(Hash) }
      flattened_response.map do |h|
          if h.has_key? 'result'
            if h['result'].is_a? Hash
              m = Hashie::Mash.new(h['result'])
            else
              m = Hashie::Mash.new(h)
            end
            m.extend(Extensions::Mash)
          end
      end
    end
  end
end

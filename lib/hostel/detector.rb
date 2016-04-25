module Hostel
  class Detector
    attr_reader :site
    def initialize(request_domain, pinned_site=nil)
      host_components = request_domain.split(':')
      request_domain = host_components[0]
      port = host_components[1]
      @request_domain = if pinned_site && Hostel.pinning_enabled?
        Hostel.find(pinned_site).domain
      else
        request_domain.to_s
      end

      @site = detect || Hostel.default_site
      @site.port = port
    end

    private

    def detect
      Hostel.all.detect do |site|
        site.domain.include?(@request_domain)
      end
    end
  end
end

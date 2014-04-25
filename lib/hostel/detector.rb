module Hostel
  class Detector
    attr_reader :site
    def initialize(request_domain, pinned_site=nil)
      @request_domain = if pinned_site && Hostel.pinning_enabled?
        Hostel.find(pinned_site).fqdn
      else
        request_domain.to_s
      end

      @site = detect || Hostel.default_site
    end

    private

    def detect
      Hostel.all.detect do |site|
        site.domain.include?(@request_domain)
      end
    end
  end
end

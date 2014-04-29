module Hostel
  class DomainConstraint
    def initialize(site_key)
      @site_key = site_key.to_s
    end

    def matches?(request)
      current_site = Hostel::Detector.new(request.domain, request.cookies['pinned']).site
      current_site.key == @site_key
    end
  end
end

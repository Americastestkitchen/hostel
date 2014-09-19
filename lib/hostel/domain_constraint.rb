module Hostel
  class DomainConstraint
    def initialize(*site_keys)
      @site_keys = site_keys.map(&:to_s)
    end

    def matches?(request)
      current_site = Hostel::Detector.new(request.host, request.cookies['pinned']).site
      @site_keys.include?(current_site.key)
    end
  end
end

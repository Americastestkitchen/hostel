module Hostel
  class DomainConstraint
    def initialize(*site_keys)
      @site_keys = site_keys.map(&:to_s)
    end

    def matches?(request)
      if request.headers['X-PROXIED-FOR']
        current_site = Hostel::Detector.new(request.headers['X-PROXIED-FOR'], request.cookies['pinned']).site
      else
        current_site = Hostel::Detector.new(request.host, request.cookies['pinned']).site
      end
      @site_keys.include?(current_site.key)
    end
  end
end

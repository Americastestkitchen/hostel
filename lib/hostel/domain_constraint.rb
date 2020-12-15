module Hostel
  class DomainConstraint
    def initialize(*site_keys)
      @site_keys = site_keys.map(&:to_s)
    end

    def matches?(request)
      current_site = if subdomain_override?(request)
        subdomain_override(request)
      elsif request.headers['X-PROXIED-FOR']
        Hostel::Detector.new(request.headers['X-PROXIED-FOR'], request.cookies['pinned']).site
      else
        Hostel::Detector.new(request.host_with_port, request.cookies['pinned']).site
      end
      @site_keys.include?(current_site.key)
    end

    def subdomain_override?(request)
      ['cio', 'cco'].each do |sk|
        return Hostel.find(sk) if request.subdomain.include?(sk)
      end
      nil
    end

    # method delegation to express that this can also be used to retrive the value
    def subdomain_override(request)
      subdomain_override?(request)
    end
  end
end

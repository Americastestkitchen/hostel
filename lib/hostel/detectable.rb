require 'active_support'

module Hostel
  module Detectable
    extend ActiveSupport::Concern

    included do
      helper_method :current_site
      helper Hostel::Helper
    end

    def current_site
      @current_site ||= begin
        if site = subdomain_override?(request)
          site
        elsif site = Hostel.find(request.params[:pinned])
          cookies[:pinned] = site.key
          Hostel::Detector.new(site.domain).site
        elsif request.headers['X-PROXIED-FOR']
            Hostel::Detector.new(request.headers['X-PROXIED-FOR'], cookies[:pinned]).site
        else
          Hostel::Detector.new(request.host_with_port, cookies[:pinned]).site
        end
      end
    end

    private
    def subdomain_override?(request)
      ['cio', 'cco'].each do |sk|
        return Hostel.find(sk) if request.subdomain.include?(sk)
      end
      nil
    end
  end
end

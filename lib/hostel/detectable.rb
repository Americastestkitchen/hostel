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
        if params[:subcategory] === "cookscountry"
          Hostel::Detector.new('cookscountry.com').site
        elsif params[:subcategory] === "cooksillustrated"
          Hostel::Detector.new('cooksillustrated.com').site
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
  end
end

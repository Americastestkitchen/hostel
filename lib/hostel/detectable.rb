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
        if site = Hostel.find(request.params[:pinned])
          cookies[:pinned] = site.key
          Hostel::Detector.new(site.domain).site
        else
          Hostel::Detector.new(request.host, cookies[:pinned]).site
        end
      end
    end
  end
end

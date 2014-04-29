module Hostel
  module Helper
    def site(*site_key, &block)
      site_key.map(&:to_s).include?(current_site.key) ? capture(&block) : nil
    end
  end
end

require 'ostruct'
require 'active_support'
require 'active_support/core_ext/module/delegation'

module Hostel
  class Site < OpenStruct
    # OpenStructs don't convert to json very well,
    # so we convert to hash first
    delegate :to_json, :as_json, to: :to_h

    def initialize(*args)
      super
      self.class.delegate "#{self.key}?", to: :inquirable_key
    end

    def domain
      @domain ||= [self.subdomain, self.domain_without_subdomain].join('.')
    end

    def inquirable_key
      ActiveSupport::StringInquirer.new(self.key.to_s)
    end

    def to_json
      data = self.as_json
      data[:domain] = domain
      data.to_json
    end
  end
end

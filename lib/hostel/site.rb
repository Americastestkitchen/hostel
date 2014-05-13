require 'ostruct'
require 'active_support'
require 'active_support/core_ext/module/delegation'

module Hostel
  class Site < OpenStruct
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

    def as_json(options = nil)
      self[:domain] = domain
      self.to_h.as_json(options)
    end
  end
end

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
    
    # Constructs a url for a path on this site
    def build_path(path, secure: true, path_args: {}, request_host: nil)
      local_env = domain.include? 'www-test'
      qa_env = request_host&.include? 'qa.herokuapp.com'

      url = if secure && !local_env
        'https://'
      else
        'http://'
      end

      qa_env ? url << request_host : url << domain

      if local_env
        url << ':' + ENV['WEBSERVERPORT']
      end

      if path && !path.empty?
        url << '/' + path.gsub(/\A\/+/, "")
      end

      if !path_args.empty?
        url << '?' + path_args.map{|k, v| "#{k}=#{v}"}.join('&')
      end

      url
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

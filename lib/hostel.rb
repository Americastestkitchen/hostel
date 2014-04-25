module Hostel
  def self.load_sites(data)
    @all = data.map do |site|
      Site.new(site)
    end
    @default_site = all.first
  end

  def self.configure(&blk)
    if block_given?
      self.class_eval(&blk)
    end
    load_sites(YAML.load_file(@sites_file))
    if @site_initializer.present?
      all.each do |site|
        site.instance_eval(&@site_initializer)
      end
    end
  end

  def self.pinning_enabled?
    @pinning_disabled ||= false
    !@pinning_disabled
  end

  def self.disable_pinning
    @pinning_disabled = true
  end

  def self.sites_file(filename)
    @sites_file = filename
  end

  def self.default_site
    @default_site ||= nil
  end

  def self.each_site(&blk)
    @site_initializer = blk
  end

  def self.all
    @all ||= []
  end

  def self.find(key)
    all.detect{|site| site.key == key.to_s }
  end

  def self.find_all(keys)
    keys = keys.to_a.map(&:to_s).compact
    all.select{|site| keys.include?(site.key.to_s) }
  end
end

require 'hostel/detectable'
require 'hostel/detector'
require 'hostel/domain_constraint'
require 'hostel/site'
require "hostel/version"

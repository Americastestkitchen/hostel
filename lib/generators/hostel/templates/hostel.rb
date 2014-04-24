Hostel.configure do
  sites_file Rails.root.join('config/sites-example.yml')
  each_site do |site|
    site.subdomain = ENV['HOSTEL_SUBDOMAIN']
    subdomain = Rails.configuration.subdomain
    self.domain = "#{subdomain}.#{self.domain_without_subdomain}"
    self.subdomain = subdomain
  end
end

Hostel.configure do
  sites_file Rails.root.join('config/sites.example.yml')

  if Rails.env.production?
    disable_pinning
  end

  each_site do |site|
    site.subdomain = Rails.configuration.subdomain
  end
end

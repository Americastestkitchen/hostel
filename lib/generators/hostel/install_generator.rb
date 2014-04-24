require 'rails/generators'
module Hostel
  class InstallGenerator < Rails::Generators::Base
    ENVIRONMENT_HASH = {
      'dev' => 'development.rb',
      'staging' => 'staging.rb',
      'production' => 'production.rb'
    }

    FILES_HASH = {
      'hostel.rb' => 'initializers',
      'sites-example.yml' => ''
    }

    desc 'Install hostel generator with sample yml file.'
    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def create_install_file
      FILES_HASH.each do |file, dir|
        copy_file file, Rails.root.join('config', dir, file)
      end
    end

    def alter_environment_files
      ENVIRONMENT_HASH.each do |subdomain, env|
        file = Rails.root.join('config', 'environments', env)
        if file.exist?
          inject_into_file file, "\nconfig.subdomain = '#{subdomain}'", after: /configure do/
        end
      end
    end
  end
end

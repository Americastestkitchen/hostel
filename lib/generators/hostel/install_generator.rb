require 'rails/generators'
module Hostel
  class InstallGenerator < Rails::Generators::Base
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
  end
end

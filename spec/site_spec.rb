require 'hostel'

describe Hostel::Site, '#inquirable_key' do
  it 'is inquirable' do
    site = Hostel::Site.new(key: 'test')
    site.inquirable_key.test?.should == true
    site.inquirable_key.other?.should == false
  end
end

describe Hostel::Site, 'key delegation' do
  it 'delegates key' do
    site = Hostel::Site.new(key: 'test')
    other_site = Hostel::Site.new(key: 'other')

    site.test?.should == true
    site.other?.should == false
  end
end

describe Hostel::Site, '#build_path' do
  it 'returns secure url with path with one arg' do
    site = Hostel::Site.new(key: 'test', subdomain: 'www-test', domain_without_subdomain: 'americastestkitchen.com')
    site.build_path('order').should == 'https://www-test.americastestkitchen.com/order'
  end

  it 'returns secure url with path with one arg with leading slash' do
    site = Hostel::Site.new(key: 'test', subdomain: 'www-test', domain_without_subdomain: 'americastestkitchen.com')
    site.build_path('/order').should == 'https://www-test.americastestkitchen.com/order'
  end

  it 'returns insecure url with secure set to false' do
    site = Hostel::Site.new(key: 'test', subdomain: 'www-test', domain_without_subdomain: 'americastestkitchen.com')
    site.build_path('/order', secure: false).should == 'http://www-test.americastestkitchen.com/order'
  end

  it 'returns secure url with params when params are set' do
    site = Hostel::Site.new(key: 'test', subdomain: 'www-test', domain_without_subdomain: 'americastestkitchen.com')
    site.build_path('order', path_args: { :incode => 'ATKSTUFF', "extcode" => "CIOTHINGS" }).should == 'https://www-test.americastestkitchen.com/order?incode=ATKSTUFF&extcode=CIOTHINGS'
  end
end

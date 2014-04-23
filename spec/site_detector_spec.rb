require 'hostel'

describe Hostel::Detector, '#new' do
  it 'sets site correctly' do
    site = Hostel::Site.new(key: 'test', domain_without_subdomain: 'testdomain.com')
    Hostel.all << site

    detector = Hostel::Detector.new('testdomain.com')
    detector.site.should == site
  end

  it 'defaults site to DEFAULT_SITE' do
    detector = Hostel::Detector.new('madeup.com')
    detector.site.should == Hostel.default_site
  end

  it 'uses a pinned site if one is provided' do
    site = Hostel::Site.new(key: 'test', domain_without_subdomain: 'testdomain.com')
    Hostel.all << site

    detector = Hostel::Detector.new('madeup.com', 'test')
    detector.site.should == site
  end
end

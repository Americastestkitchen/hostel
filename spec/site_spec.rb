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

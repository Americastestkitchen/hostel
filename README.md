# Hostel

Hostel is a lightweight library for serving different (but similar) websites from the same Rails application.

## Installation

Add this line to your application's Gemfile:

    gem 'hostel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hostel

Then run:

    $ rails g hostel:install

This will create `config/initializers/hostel.rb` and `config/sites.yml`.

### Configuration

Hostel expects your sites to have three attributes: `key`,
`domain_without_subdomain`, and `subdomain`. `key` and
`domain_without_subdomain` by default come from `sites.yml`, and `subdomain` is
set in the initializer based on a subdomain value set in your environment
files. This allows you to use your `/etc/hosts` file to match different sites
locally and use subdomains in staging environments to map to the correct sites.
`site.domain` will always be the FQDN for the current environment.

You can include any other key/value pairs you like in the YAML configuration
file and they will also be given accessors on the corresponding `Hostel::Site`
instance.

## Usage

### Accessing sites manually

`Hostel::Site` instances can be looked up by their key using
`Hostel.find(:yourkey)`, and you can retrieve an array of all sites with
`Hostel.all`.

The instances will all have your site key names as boolean methods. For
example, to test the identify of a `Hostel::Site` instance, you can call
`site.google?` instead of `site.key == :google`.

### Routing constraints

If you need to constrain a set of routes to a single site in your sites.yml,
pass `Hostel::DomainConstraint.new(:yoursitekey)` to `constraint` in your
`routes.rb`.

### Automatic retrieval of current site

Hostel provides the `Hostel::Detectable` controller concern. This gives you
some convenient utilities:

* `current_site` is a controller method and a helper method for your views. It
  matches based on subdomain and domain (not port).
* The `site` helper takes one or more site keys and a block. This allows you to
  have site-specific blocks of content in your views -- the content will only
  render if `current_site` matches one of the keys given.

### Site pinning

In many cases, it's useful to force the value of `current_site` to one site or
another for testing. If site pinning is enabled, Hostel will look for a
querystring parameter of `pinned`. If the value of `pinned` matches the key of
a site, it will set a cookie that will override host-based site detection
algorithm.

Site pinning is disabled for production by default in the generated initializer.

### Path building

If you want to build links to different tenants on the system, we have a handy
new `build_path` method. This can be used to do cool things.

Example usage:

* Build a link to the upgrade path on the current site
`current_site.build_path('upgrade')`

* Build a link to a recipe on the current site, insecurely
`current_site.build_path('/recipe/2487-some-delicious-recipe', secure: false)
- By default, build_path uses https

* Build a link to the order page, with query parameters

`current_site.build_path('order', params: { :incode => 'CIOSTUFF', :purchase_type => 'instructor_access' })`

* Build a link to the Cooking School Courses page from Everest

`Hostel.find('school_main').build_path('courses', secure: false, params: { :stuff => 'OTHERSTUFF' })`

* Build a link to the support page

`current_site.build_path(support_path, secure: false)`


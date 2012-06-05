source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# primary dependencies
gem 'pg'
gem 'sorcery'
gem 'therubyracer'
gem 'geocoder'
gem 'heroku'

# for internal json api
gem 'rabl'
gem 'json'

# for outside api's
gem 'ruby-rets', :git => 'https://github.com/Placester/ruby-rets.git'

# Batsd stuff
gem 'statsd-ruby', :git => 'https://github.com/jeremy/statsd-ruby.git', require: 'statsd'

# had to add this due to broken dependencies chain, most likely one of the sass gems
gem 'bcrypt-ruby'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'rspec-rails', :group => [:test, :development]
group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'factory_girl_rails'
  gem 'capybara'
end

run "rm Gemfile"

file "Gemfile", <<-INIT

source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem "sqlite3"
gem "thin"
gem "pg"
#gem "mongoid"
#gem "bson_ext"
#gem "squeel"
gem "haml"
gem "jquery-rails"
# gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'inherited_resources', :git => "git://github.com/josevalim/inherited_resources.git"
gem "friendly_id"
gem "devise", :git => "git://github.com/plataformatec/devise.git"
gem "carrierwave", :git => 'git://github.com/jnicklas/carrierwave.git'
#gem "omniauth", '0.2.6' #:git => "git://github.com/intridea/omniauth.git"# ,:ref => ""
#gem "twitter"#, :git => 'git://github.com/jnunemaker/twitter.git'
gem 'will_paginate', '> 3.0'

group :assets do
	gem 'compass', git: 'https://github.com/chriseppstein/compass.git'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

group :production do
	#gem "newrelic_rpm"
end

group :development, :test do
	gem "capistrano"
	gem "guard", :git => "git://github.com/guard/guard.git"
	gem "guard-bundler"
	gem "guard-rails", :git => "git://github.com/guard/guard-rails.git"
	gem "guard-rspec"
	gem "guard-livereload"
	gem "factory_girl_rails"

	# Useful for fake data generation
	gem "faker"
	
	gem "capybara", :require => 'capybara/rspec'
	gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'

	gem "rspec-rails"# , '2.6.0' #, '2.5.0'
	gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
end
INIT

run "bundle install"

run "rm public/index.html"
generate :controller, "Home index"
generate :model, "Home"
generate "rspec:install"
generate "devise:install"
generate "devise User"
generate "devise:views"
capify!

rake "db:migrate"
route 'root :to => "home#index"'

git :init
git :add => "."
git :commit => "-am 'Application Setup'"
git :branch => "development"


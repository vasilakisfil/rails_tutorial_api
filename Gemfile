source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails',                   '~> 4.2.6'
gem 'bcrypt',                  '~> 3.1.7'
gem 'faker',                   '~> 1.4.2'
gem 'carrierwave',             '~> 0.10.0'
gem 'mini_magick',             '~> 3.8.0'
gem 'fog',                     '~> 1.23.0'
gem 'will_paginate',           '~> 3.0.7'
gem 'bootstrap-will_paginate', '~> 0.0.10'
gem 'bootstrap-sass',          '~> 3.2.0.0'
gem 'sass-rails',              '~> 5.0.0.beta1'
gem 'uglifier',                '~> 2.5.3'
gem 'coffee-rails',            '~> 4.0.1'
gem 'jquery-rails',            '~> 4.0.0.beta2'
gem 'turbolinks',              '~> 2.3.0'
gem 'jbuilder',                '~> 2.2.3'
gem 'arel',                    '~> 6.0.0'
gem 'sdoc',                    '~> 0.4.0', group: :doc

gem 'pg'
gem 'rack-cors', :require => 'rack/cors'
gem 'active_hash_relation', github: 'kollegorna/active_hash_relation'

#api related
gem 'pundit', '~> 0.3.0'
#gem 'active_model_serializers',
#  git: 'git@github.com:rails-api/active_model_serializers.git',
#  branch: '0-9-stable'

gem 'active_model_serializers', git: 'git://github.com/rails-api/active_model_serializers.git'
gem 'kaminari', '~> 0.16.1'
gem 'redis-throttle', git: 'git://github.com/andreareginato/redis-throttle.git'
gem 'rspec-api_helpers', github: 'kollegorna/rspec-api_helpers'
gem 'net-ssh'

group :development, :test do
  gem 'pry-rails'
  gem 'sqlite3',     '1.3.9'
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :development do
  gem 'annotate', git: 'git@github.com:ctran/annotate_models.git', branch: 'develop'
  gem 'erd'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'

  gem 'rspec-rails', '~> 3.1.0'
  gem 'database_cleaner', '~> 1.3.0'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',        '4.8.3'
  gem 'newrelic_rpm'
end

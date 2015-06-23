source 'https://rubygems.org'
ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # testing
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # add property commetn
  gem 'annotate'

  # for better development
  gem 'rails_best_practices'
end

# for twitter-auth
gem 'omniauth'
gem 'omniauth-twitter'

# for heroku
group :production do
  gem 'rails_12factor'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails_serve_static_assets', github: 'heroku/rails_serve_static_assets'
  gem 'unicorn'
end

# for testing
group :test do
  # for end-to-end test
  gem 'capybara'
  # for validation expectation
  gem 'shoulda-matchers'
  # for end-to-end test with js
  gem 'poltergeist'
  gem 'database_cleaner'
end

# for logical delete
gem 'paranoia'

# for image upload
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'

# for tag
gem 'acts-as-taggable-on'
gem 'jquery-ui-rails'

# for tag-auto-complete
gem 'gon'

# for pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# for flat-ui
gem 'flatui-rails'
gem 'select2-rails'

# for font-awesome
gem 'font-awesome-rails'

# for slack-notification
gem 'slack-notifier'

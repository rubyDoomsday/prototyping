source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass',      '~> 3.3', '>= 3.3.6'
gem 'font-awesome-rails',  '~> 4.7', '>= 4.7.0.2'
gem 'jbuilder',            '~> 2.5'
gem 'jquery-rails',        '~> 4.3', '>= 4.3.1'
gem 'mongoid',             '~> 6.2.0'
gem 'puma',                '~> 3.7'
gem 'rails',               '~> 5.1.4'
gem 'responders',          '~> 2.3'
gem 'rest-client',         '~> 2.0.2'
gem 'sass-rails',          '~> 5.0'
gem 'sprockets-rails',     '~> 3.2.1', '>= 2.2.4'
gem 'turbolinks',          '~> 5'
gem 'uglifier',            '>= 1.3.0'

group :development, :test do
  gem 'byebug',              platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors',       '~> 2.1', '>= 2.1.1'
  gem 'binding_of_caller',   '~> 0.7.2'
  gem 'database_cleaner',    '~> 1.6', '>= 1.6.1'
  gem 'factory_girl_rails',  '~> 1.5'
  gem 'pry',                 '~> 0.10.3'
  gem 'rspec-rails',         '~> 3.6'
end

group :development do
  gem 'listen',                 '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'
  gem 'web-console',            '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

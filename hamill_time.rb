say "STOP! Hamill Time!"
app_name = File.split(`pwd`.chomp).last

# Write your own README, yo.
run 'rm README.rdoc'
file 'README.md', <<-MARKDOWN
# #{app_name.camelize}

Write a short description here.

## Getting Going

Write instructions for how to get your app from checkout to green tests here.
MARKDOWN

# Clean up and betterize the Gemfile.
run 'cat Gemfile | grep -v "#" | cat --squeeze-blank - > Gemfile.new && mv Gemfile.new Gemfile'
run %Q(echo "#{<<-GEMFILE.chomp}" >> Gemfile)
gem 'pry-rails'
gem 'pry-doc'
gem 'slim-rails'
gem 'thin'

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara-webkit'
end
GEMFILE
run 'bundle install'

# Set up RSpec
run 'rails generate rspec:install'
run %Q(echo "#{<<-SPEC_HELPER.chomp}" >> spec/spec_helper.rb)

require 'capybara/rspec'
Capybara.javascript_driver = :webkit
SPEC_HELPER

# Clean up database.yml
run 'cat config/database.yml | grep -v "#" | grep -v "username" | grep -v "password" | cat --squeeze-blank - > config/database.yml.new && mv config/database.yml.new config/database.yml'
run 'rake db:create'
run 'rake db:migrate'

git :init
git add: '.'
git commit: '-m "Green field Rails app."'
say "Done: #{app_name} is good to go!", :green

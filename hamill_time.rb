app_name = File.split(`pwd`.chomp).last.camelize

run 'rm README.rdoc'
file 'README.md', <<-MARKDOWN
# #{app_name.camelize}

Write a short description here.

## Getting Going

Write instructions for how to get your app from checkout to green tests here.
MARKDOWN
run 'rm -rf doc/'

run 'cat Gemfile | grep -v "#" | cat --squeeze-blank - > Gemfile.new && mv Gemfile.new Gemfile'
run %Q(echo "#{<<-GEMFILE}" >> Gemfile)
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
run 'rails generate rspec:install'

run 'cat config/database.yml | grep -v "#" | grep -v "username" | grep -v "password" | cat --squeeze-blank - > config/database.yml.new && mv config/database.yml.new config/database.yml'
run 'rake db:create'
run 'rake db:migrate'

git :init
git add: '.'
git commit: '-m "Green field Rails app."'

say "OK. You need to mess with your test setup. Look here: http://rubydoc.info/gems/capybara#Using_Capybara_with_RSpec and here: http://rubydoc.info/gems/capybara-webkit#Usage", :yellow

# Omakase

The name is a reference to [a blog post by DHH](http://david.heinemeierhansson.com/2012/rails-is-omakase.html)
and the reference, and this very repository, was inspired by [a blog post by
Giles Bowkett](http://gilesbowkett.blogspot.com/2013/01/we-can-solve-multiple-default-stacks.html).

I'ma put my [Rails Application Templates](http://guides.rubyonrails.org/rails_application_templates.html)
in here. Feel free to use them for whatever (see LICENSE for details).

## But... *How*?!?

Like so:

    $ rails new stop -m ~/hamill_time.rb -Td postgresql --skip-bundle

You might like to [create a bash alias](https://gist.github.com/4662043)
(thanks, Giles):

```bash
function rails_personal() {
  rails new $* --skip-bundle --database=postgresql --skip-test-unit --template=https://raw.github.com/benhamill/omakase/master/hamill_time.rb
}
```

## I know. It is a really bad pun.

It:

* Replaces the standard README.rdoc with your own README.md and gets rid of
  /doc.
* Clears comments from the Gemfile.
* [pry](https://github.com/pry/pry)
* [slim](https://github.com/slim-template/slim)
* [thin](https://github.com/macournoyer/thin)
* [rspec](https://github.com/rspec/rspec)
* [capybara-webkit](https://github.com/thoughtbot/capybara-webkit)
* Clean up `config/database.yml` a bit.
* Assumes you'll deploy to Heroku (hence postgres, thin and database.yml).
* Initializes a git repo and commits the blank app.

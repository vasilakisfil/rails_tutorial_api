# Ruby on Rails Tutorial with API: sample application

[![circleci build](https://circleci.com/gh/vasilakisfil/rails_tutorial_api.svg?style=shield&circle-token=b3c068bc50b4672f403bbebe0c8dc4152cc275c4)](https://circleci.com/gh/vasilakisfil/rails_tutorial_api)

This is the sample application for the
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/) **but with an API for the [Ember version](https://github.com/vasilakisfil/rails_tutorial_ember)**.

It's deployed [here](https://rails-tutorial-api.herokuapp.com/).
Ember version is deployed [here](https://ember-on-rails-tutorial.herokuapp.com) and there is a [blog post](https://labs.kollegorna.se/blog/2015/04/build-an-api-now/) about it

You can use this reference implementation to help track down errors if you end up having trouble with code in the tutorial.
In particular, as a first debugging check I suggest getting the test suite to pass on your local machine:

```
$ cd /tmp
$ git clone https://github.com/mhartl/sample_app_3rd_edition.git
$ cd sample_app_3rd_edition
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake test
```

The repository also has chapter-specific branches with the state of the code at the end of each chapter. You can view them as follows:

```
$ git branch --all
  .
  .
  .
  remotes/origin/account-activation-password-reset
  remotes/origin/filling-in-layout
  remotes/origin/following-users
  remotes/origin/log-in-log-out
  remotes/origin/master
  remotes/origin/modeling-users
  remotes/origin/sign-up
  remotes/origin/static-pages
  remotes/origin/updating-users
  remotes/origin/user-microposts
```

To check out one of these chapter-specific branches, just use `git checkout` followed by the name without `remotes/origin`:

```
$ git checkout log-in-log-out
```

This should help you track down any discrepancies between your code and the code in the tutorial.

# Ruby Videos

[![Codeship Status for andypike/ruby_videos](https://codeship.com/projects/1514f450-858d-0132-4c4f-76a8aba63565/status?branch=master)](https://codeship.com/projects/58779)
[![Code Climate](https://codeclimate.com/github/andypike/ruby_videos/badges/gpa.svg)](https://codeclimate.com/github/andypike/ruby_videos)
[![Test Coverage](https://codeclimate.com/github/andypike/ruby_videos/badges/coverage.svg)](https://codeclimate.com/github/andypike/ruby_videos)

A curated listing of quality videos about or related to the Ruby programming
language.

## Setup

```
git clone git@github.com:andypike/ruby_videos.git
cd ruby_videos
cp config/example.database.yml config/database.yml
cp example.env .env
  * Add your development details to .env
psql postgres
# create user ruby_videos with password '' CREATEDB;
# \q
bundle
rake db:create db:migrate db:seed
rake db:create db:migrate RAILS_ENV=test
rails s
```

## Why?

I wanted a simple project that I could experiment around with and try out some
different things. There is also a [Trailblazer version](https://github.com/andypike/ruby_videos_trailblazer)
of this project that I started first. The reason for this project is that I liked
many on the concepts in [Trailblazer](https://github.com/apotonick/trailblazer)
but also wondered if I could do something similar with just standard Rails and
POROs (with a few lightweight gems).

### Responsibilities

Based on the Trailblazer experiment and some other things I've been thinking
and reading about, here are the general principles, structure responsibilities
of the different areas of the project. These are ideas and plans before I start
building the app. These may change over time.

#### Controllers

These are the entry point to our application. They deal with HTTP concerns such
as reading the input, redirecting and rendering. They cannot contain business
logic. To perform business logic they must call an Operation (one per action if
possible).

#### Models

Models derived from `ActiveRecord::Base` are only allowed to query the database.
So these models should only contain the relationship bindings (`belongs_to`,
`has_many` etc), scopes or class query methods. So AR models are only concerned
with data access. AR models are the only classes that can call AR query methods
such as `#where` etc.

#### Operations

A class that is responsible for the business logic of a single task in the
system and should be named using verbs. For example, `PlaceOrder`,
`RegisterUser` or  `PublishArticle`. These classes should have no knowledge of
HTTP or how to query the database. If they require data they can only call
AR-model query methods are defined in the model class not built in AR calls such
as `#where` etc. The only exceptions to this are `#find(id)` or `#find_by`.

If an Operation needs to update/insert then they can use the normal AR methods
(`#create`, `#save`, `update`, etc).

Operations should be namespaced by concept. A concept may be a thing in the
system such as User or something more abstract like Security. Concepts don't
have to be mapped to your AR models but they can be.

#### Form Objects

These objects are responsible for dealing with data input from a user. They will
be populated from the params hash and will validate it. I would like to keep
these as close to simple POROs but I suspect I'll use a gem here which will make
it easier to integrate with form builders such as [simple_form](https://github.com/plataformatec/simple_form).

The idea here is to remove the need to use strong_parameters as the form object
will only use fields it's expecting for it's job. Also, this is an attempt to
remove the need to use the ever confusing `#accepts_nested_attributes_for` by
simplifying the forms so they only bind to a simple form object.

#### Mappers

The mappers will be responsible for taking the data held by a form object and
mapping that data onto AR models for persistence (and back again). I may add
some niceness for auto-mapping attributes with matching names etc, but we'll see
how that goes.

#### Views

I would like to keep the views as simple as possible. Recently I've been using
decorators ([Draper gem](https://github.com/drapergem/draper)) to add UI
formatting to models. However, I'd like to try something different. I like the
idea of having a presenter that takes a model(s) and is responsible manipulating
the data for the view. This is more like the [Cells gem](https://github.com/apotonick/cells)
which I may well use. So rather than a decorator per model we should have a
presenter per view/partial. This presenter acts like a View Model.

### Testing

In terms of testing there are few new things that I'd like to try out.

#### Page Objects

When testing with [Capybara](https://github.com/jnicklas/capybara) I'd like to
start using Page Objects to encapsulate details of a page. For example, filling
in forms and navigating to pages. This is an attempt to remove the details from
the test and make them more focused on what you are trying to test. This makes
things easier when coming back and reading the tests.

#### JS Tests

Testing javascript in a Rails app has been painful for me up to this point.
Using Capybara with the `:js` tag really slows down the suite and are normally
problematic. Simple things work ok, but more complex tests are hard to write and
unreliable to run (especially in CI). So I'd like to try out some ways to
improve this. I'd like to run up the app in a headless browser and then stub out
the server side. I want to take a look at [Teaspoon](https://github.com/modeset/teaspoon)
and investigate other solutions.

#### Mocking and fast tests

I normally try to avoid too much mocking if I can. But in an attempt to keep the
tests fast I will still use factories to populate the database but only for
Model query tests. As these are the only classes allowed to perform data access
and will be tested, these calls can be mocked out for other tests. This should
keep the tests fast but on the other hand, they will have implementation details
(the mocks) inside them. Again, something to experiment with.

## When is this style appropriate?

The structure above is not appropriate if you know you are only building a
simple crud style app. This is overkill for that. However, a lot of apps start
out simple and then increase in complexity over time. What I am trying to do
here is to create a structure that consists of many small parts, each with their
own single responsibility. As the app increases in complexity, this should
provide a solid foundation for future change.

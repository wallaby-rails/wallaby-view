# Wallaby::View

[![Gem Version](https://badge.fury.io/rb/wallaby-view.svg)](https://badge.fury.io/rb/wallaby-view)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Travis CI](https://travis-ci.org/wallaby-rails/wallaby-view.svg?branch=master)](https://travis-ci.org/wallaby-rails/wallaby-view)
[![Maintainability](https://api.codeclimate.com/v1/badges/d3e924dd70cc12562eab/maintainability)](https://codeclimate.com/github/wallaby-rails/wallaby-view/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d3e924dd70cc12562eab/test_coverage)](https://codeclimate.com/github/wallaby-rails/wallaby-view/test_coverage)
[![Inch CI](https://inch-ci.org/github/wallaby-rails/wallaby-view.svg?branch=master)](https://inch-ci.org/github/wallaby-rails/wallaby-view)

Wallaby::View is a Ruby gem that extends Rails layout/template/partial inheritance chain to allow searching layout/template/partial using action name and theme name.

## Install

Add Wallaby::View to `Gemfile`.

```ruby
gem 'wallaby-view'
```

And re-bundle.

```shell
bundle install
```

## Basic Usage

For example, there are the following controllers:

```ruby
# app/controllers/application_controller
class ApplicationController < ActionController::Base
end

# app/controllers/admin/application_controller
class Admin::ApplicationController < ApplicationController
  self.theme_name = 'secure'
end

# app/controllers/admin/users_controller
class Admin::UsersController < Admin::ApplicationController
  self.theme_name = 'account'
  def edit; end
end
```

The lookup order of `admin/users#edit` action becomes:

- app/views/admin/users/edit
- app/views/admin/users
- app/views/account/edit
- app/views/account
- app/views/admin/application/edit
- app/views/admin/application
- app/views/secure/edit
- app/views/secure
- app/views/application/edit
- app/views/application

Then it becomes possible to create a partial in `app/views/admin/users/edit` just for `admin/users#edit` action, for instance:

```erb
<%# app/views/admin/users/edit.html.erb %>
<% render 'form' %>

<%# app/views/admin/users/edit/_form.html.erb %>
This is form only for edit action
```

## Documentation

- [API Reference](https://www.rubydoc.info/gems/wallaby-view)
- [Change Logs](CHANGELOG.md)

## Want to contribute?

Raise an issue, discuss and resolve!

## License

This project uses [MIT License](LICENSE).

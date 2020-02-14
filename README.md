# [Wallaby::View](https://github.com/wallaby-rails/wallaby-view)

[![Gem Version](https://badge.fury.io/rb/wallaby-view.svg)](https://badge.fury.io/rb/wallaby-view)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Travis CI](https://travis-ci.com/wallaby-rails/wallaby-view.svg?branch=master)](https://travis-ci.com/wallaby-rails/wallaby-view)
[![Maintainability](https://api.codeclimate.com/v1/badges/d3e924dd70cc12562eab/maintainability)](https://codeclimate.com/github/wallaby-rails/wallaby-view/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d3e924dd70cc12562eab/test_coverage)](https://codeclimate.com/github/wallaby-rails/wallaby-view/test_coverage)
[![Inch CI](https://inch-ci.org/github/wallaby-rails/wallaby-view.svg?branch=master)](https://inch-ci.org/github/wallaby-rails/wallaby-view)

`Wallaby::View` is a Ruby gem that extends Rails layout/template/partial inheritance chain to allow searching layout/template/partial using theme name and action name.

## Install

Add `Wallaby::View` to `Gemfile`.

```ruby
gem 'wallaby-view'
```

And re-bundle.

```shell
bundle install
```

Include `Wallaby::View` in the target controller (e.g. `ApplicationController`):

```ruby
# app/controllers/application_controller
class ApplicationController < ActionController::Base
  include Wallaby::View
end
```

## What It Does

For example, given the following controllers:

```ruby
# app/controllers/application_controller
class ApplicationController < ActionController::Base
  include Wallaby::View
end

# app/controllers/admin/application_controller
class Admin::ApplicationController < ApplicationController
  self.theme_name = 'secure'
end

# app/controllers/admin/users_controller
class Admin::UsersController < Admin::ApplicationController
  self.theme_name = 'account'
  self.options = { mapping_actions: { edit: 'form' } }
end
```

By using `Wallaby::View`, the lookup folder order of `admin/application#edit` action becomes:

- app/views/admin/application/edit
- app/views/admin/application
- app/views/secure/edit
- app/views/secure
- app/views/application/edit
- app/views/application

Then it is possible to create a relative partial in one of the above folder for `admin/application#edit` action, for instance:

```erb
<%# app/views/admin/application/edit.html.erb %>
<% render 'form' %>

<%# app/views/secure/edit/_form.html.erb %>
This form partial is under `secure` theme and `edit` action,
but still can be rendered by `admin/application#edit` action
```

For `admin/users#edit` action, since `mapping_actions` option is set, `edit` will be mapped to `form`.
Therefore, the lookup folder order of `admin/users#edit` becomes:

- app/views/admin/users/form
- app/views/admin/users
- app/views/secure/form
- app/views/secure
- app/views/admin/application/form
- app/views/admin/application
- app/views/secure/form
- app/views/secure
- app/views/application/form
- app/views/application

## Documentation

- [API Reference](https://www.rubydoc.info/gems/wallaby-view)
- [Change Logs](https://github.com/wallaby-rails/wallaby-view/blob/master/CHANGELOG.md)

## Want to contribute?

Raise an [issue](https://github.com/wallaby-rails/wallaby-view/issues/new), discuss and resolve!

## License

This project uses [MIT License](https://github.com/wallaby-rails/wallaby-view/blob/master/LICENSE).

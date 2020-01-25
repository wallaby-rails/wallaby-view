# Wallaby::View

[![Gem Version](https://badge.fury.io/rb/wallaby-view.svg)](https://badge.fury.io/rb/wallaby-view)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Travis CI](https://travis-ci.org/wallaby-rails/wallaby-view.svg?branch=master)](https://travis-ci.org/wallaby-rails/wallaby-view)
[![Maintainability](https://api.codeclimate.com/v1/badges/d3e924dd70cc12562eab/maintainability)](https://codeclimate.com/github/wallaby-rails/wallaby-view/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d3e924dd70cc12562eab/test_coverage)](https://codeclimate.com/github/wallaby-rails/wallaby-view/test_coverage)
[![Inch CI](https://inch-ci.org/github/wallaby-rails/wallaby-view.svg?branch=master)](https://inch-ci.org/github/wallaby-rails/wallaby-view)

Wallaby::View is a Rails engine that extends Rails layout/template/partial inheritance that:

1. Allow searching template/partial in its inheritance chain plus current action name prefix.
2. Be able to use Wallaby::Cell template/partial (Ruby object) for faster view rendering.

## Install

Add Wallaby::View to `Gemfile`.

```ruby
# Gemfile
gem 'wallaby-view'
```

And re-bundle.

```shell
bundle install
```

## Basic Usage

For example, there are the following controllers:

```ruby
# in app/controllers/application_controller
class ApplicationController < ActionController::Base
end

# in app/controllers/admin_controller
class AdminController < ApplicationController
end

# in app/controllers/admin/products_controller
class Admin::ProductsController < AdminController
  def edit
  end
end
```

The lookup order for an `admin/products#edit` action will be:

- app/views/admin/products/edit
- app/views/admin/products
- app/views/admin/edit
- app/views/admin
- app/views/application/edit
- app/views/application

Then it becomes possible to create a partial in `app/views/admin/products/edit` just for `admin/products#edit` action, for instance:

```erb
<%# app/views/admin/products/edit.html.erb %>
<% render 'form' %>

<%# app/views/admin/products/edit.html.erb %>
This is form only for edit action
```

Also, it is possible to create a Wallaby::Cell partial as such:

```ruby
module Admin
  module Products
    class FormHtml < Wallaby::Cell
      def to_render
        'This is form only for edit action'
      end
    end
  end
end
```

## Documentation

- [Features and Requirements](docs/features.md)
- [Documentation](docs/README.md) for more usages and customization guides
- [API Reference](https://www.rubydoc.info/gems/wallaby)
- [Change Logs](CHANGELOG.md)

## Want to contribute?

Raise an issue, discuss and resolve!

## License

This project uses [MIT License](LICENSE).

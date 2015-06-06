Faceter
=======

[![Gem Version](https://img.shields.io/gem/v/faceter.svg?style=flat)][gem]
[![Build Status](https://img.shields.io/travis/nepalez/faceter/master.svg?style=flat)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nepalez/faceter.svg?style=flat)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/nepalez/faceter.svg?style=flat)][codeclimate]
[![Coverage](https://img.shields.io/coveralls/nepalez/faceter.svg?style=flat)][coveralls]
[![Inline docs](http://inch-ci.org/github/nepalez/faceter.svg)][inch]

[codeclimate]: https://codeclimate.com/github/nepalez/faceter
[coveralls]: https://coveralls.io/r/nepalez/faceter
[gem]: https://rubygems.org/gems/faceter
[gemnasium]: https://gemnasium.com/nepalez/faceter
[travis]: https://travis-ci.org/nepalez/faceter
[inch]: https://inch-ci.org/github/nepalez/faceter

Experimental [ROM](https://github.com/rom-rb/rom)-compatible data mapper, based on the [transproc](https://github.com/solnic/transproc) gem by [Piotr Solnica](https://github.com/solnic).

Basicaly the gem does about the same as the ROM mappers do. But its DSL has a different semantics:

* Unlike ROM mappers, that describes the structure of transformed data with *nouns* (`attribute :foo, from: :bar`), the `Faceter` DSL uses *verbs* to describe transformations (`rename :bar, to: :foo`). `Faceter` transformations are either "do this, from: that", or "change this, to: that".

* Unlike ROM, that mixes transformations (`attribute :bar, from: :foo`) with structures (wrap(:foo) { attribute :bar }), the `Faceter` strictly separates them. It uses 2 *nouns*: `list` an `field` (like `embedded` in ROM) to browse the data, and *verbs* to transform them. Only browsing can be nested and should end up with some transformation. Nested transformations are not supported.

* Due to stronger separation between browsing an transforming data, every command in `Faceter` is executed as a single `step` in ROM. The output of every transformation serves the input for the next one. This makes it possible to read mapper DSL as a set of instructions: "go to this level and change data in this way, then go to that level etc.".

* Because `Faceter` uses one-step transformations, it supports inline syntax for the transformations only. Blocks are used either to browse the data, or to provide value for the `create` command.

* Because `Faceter` describes transformations, not the structure of the output, mappers inheritance works differently. When you inherit a mapper, the subclass will do all the transformations from its superclass and then add its own.

The `Faceter` is the **experimental** gem. I've wrote it to check whether this "concept" of procedure-like syntax would work fine and not overkill the recipy with details.

Synopsis
--------

To access the data the mapper DSL has two methods, that can be nested deeply:

* `list` - "do something with every element of array"
* `field` - "do something with a value of hash key"

The mapper also has methods to transform the accessed data (either a field of some tuple or values of some array):

* `rename` to rename fields in a tuple
* `create` and `exclude` to provide a new field from other ones (while keeping those fields unchanged) or exclude the existing one(s).
* `add_prefix` and `remove_prefix` to add/remove a prefix to names of field
* `stringify_keys` and `symbolize_keys` to stringify/symbolize all keys from given layer and deeper
* `wrap` and `unwrap` to wrap a value to nested tuple or unwrap it from a tuple
* `group` and `ungroup` to group/ungroup tuples in array by some field(s)

Suppose you need to transform array of nested data:

```ruby
source = [
  {
    id: 1, name: 'Joe', roles: ['admin'],
    emails: [
      { address: 'joe@doe.com', type: 'job' },
      { address: 'joe@job.com', type: 'job' },
      { address: 'joe@doe.org', type: 'personal' }
    ]
  }
]
```

To create a mapper, include `Faceter` to the mapper class and define the sequence of transformations. Transformations will be applied step-by-step to data at a corresponding level.

```ruby
require "faceter"

class Mapper
  include Faceter

  list do
    field :roles do
      list do
        wrap to: :role
      end
    end

    rename  :emails, to: :contacts
  end

  # Both `ungroup` and `group` work with arrays as a whole. You haven't
  # wrap them to the `list` unless your data are not the arrays of arrays.
  ungroup :role, from: :roles

  group :id, :name, :contacts, to: :user

  list do
    field :user do
      field :contacts do
        list do
          rename :address, to: :email
        end

        group :address, to: :emails
      end
    end
  end
end
```

To apply transformation to the source initialize the mapper and send the source array to its `call` instance method:

```ruby
mapper = Mapper.new
mapper.call source
# => [
#      {
#        role: 'admin',
#        users: [
#          {
#            id: 1,
#            name: 'Joe',
#            contacts: [
#              { type: 'job',      emails: ['joe@doe.com', 'joe@job.com'] },
#              { type: 'personal', emails: ['joe@doe.org'] }
#            ]
#          }
#        ]
#      }
#    ]
```

Instantiating Models
--------------------

You can do any data transformations using `create` method, that does the following:

* takes values from tuple by keys given in `:from` option,
* sends those values to the block in the same order,
* assigns the result of the block either to given key, or rewrites the whole tuple with given value.

```ruby
require "faceter"
require "ostruct"

class Mapper
  include Faceter

  list do
    create from: [:id, :name, :email] do |id, name, email|
      OpenStruct.new id: id, name: name, email: email
    end
  end
end
```

Alternatively, you could wrap the necessary keys and then create new value with the same key:

```ruby
require "faceter"
require "ostruct"

class Mapper
  include Faceter

  list do
    wrap to: :user # wraps all keys in every tuple to the :user key

    create from: [:user] do |user|
      OpenStruct.new(user)
    end
  end
end
```

Both the examples transform the array of tuples:

```ruby
source = [
  { id: 1, name: "Joe",  email: "joe@doe.com"  },
  { id: 2, name: "Jane", email: "jane@doe.com" }
]
```

into the array of instances:

```ruby
mapper = Mapper.new
mapper.call(source) 
# => [
#  #<OpenStruct @id=1, @name="Joe",  @email="joe@doe.com">,
#  #<OpenStruct @id=2, @name="Jane", @email="jane@doe.com">
# ]
```

### Data Serialization

In just the same way you can serialize models at the mapper layer:

```ruby
source = [
  OpenStruct.new(id: 1, name: "Joe", email: "joe@doe.com"),
  OpenStruct.new(id: 2, name: "Jane", email: "jane@doe.com")
]

class Mapper < Faceter::Mapper
  list do
    # take every item in a list, create the value and assign it back to the item
    create do |item|
      { id: item.id, name: item.name, email: item.email }
    end
  end
end

mapper = Mapper.new
mapper.call source
# => [
#      { id: 1, name: "Joe", email: "joe@doe.com" },
#      { id: 2, name: "Jane", email: "jane@doe.com" }
#    ]
```

### ROM-compatibility

To use the mapper in [ROM] you can register it as a custom mapper for the corresponding relation:

```ruby
setup = ROM.setup :memory

setup.relation(:users)
setup.mappers { register(:users, my_mapper: mapper) }

rom = ROM.finalize.env

rom.relation(:users).as(:my_mapper).to_a
# => returns the converted data
```

Installation
------------

Add this line to your application's Gemfile:

```ruby
# Gemfile
gem "faceter"
```

Then execute:

```
bundle
```

Or add it manually:

```
gem install faceter
```

Under the Hood
--------------

The gem is organized dead simple. When you declare a subclass of the `Faceter`, it is created with the AST (Abstract Syntax Tree, describing the transformation) builder.

At the first moment the builder (`lib/faceter/builder.rb`) carries the empty AST, that is later populated by nodes with the help of mapper DSL (`lib/faceter/dsl.rb`).

Every DSL method just adds a node (either nesting branch, or leaf transformation) to current level of the tree. 
The base class for nodes is placed to `lib/faceter/ast.rb`, its implementations for various nodes lay in the `lib/faceter/ast/` folder.

Every node of the AST has a `#transproc` instance method that defines a transformation of data on the current level of nesting (including all transformations defined by the subtree of this node). The mapper `#call` instance method just invokes the `#transproc` of the root of the AST with a source data.

One more detail. Before invocation of the root `transproc`, the `call` method optimizes the tree. At every level of nesting two consecutive branches of the tree are merged, if they describe the same layer. The AST from the following example:

```ruby
list do
  field :foo do
    rename :bar, to: :qux
  end
end

list
  field :foo do
    rename :baz, to: :quxx
  end
end
```

becomes the same as from:

```ruby
list do
  field :foo do
    rename :bar, to: :qux
    rename :baz, to: :quxx
  end
end
```

### Adding new command to the mapper DSL

To create a new DSL command:

* Provide a new class, describing the command as a node of the Abstract Syntax Tree (`lib/faceter/ast/my_new_node.rb`).
  Inherit it from either `Faceter::AST::Node` for transformations, or from `Faceter::AST::Root` for branches.
* Define the `#transproc` method, that is either transforms the current data, or composes `transprocs` of its subnodes.
* For branches define the equality `==`, that is used for merging branches that describe the same level of nesting.
* Reload the `inspect` method that depictures the node if necessary.
* Register the node under the new method in `NODES` constant of the DSL (`lib/faceter/dsl.rb`).

Compatibility
-------------

Tested under rubies [compatible to MRI 2.1+](.travis.yml).

Uses [RSpec] 3.0+ for testing and [hexx-suit] for dev/test tools collection.

[RSpec]: http://rspec.org
[hexx-suit]: https://github.com/nepalez/hexx-suit

Contributing
------------

* Read the [STYLEGUIDE](config/metrics/STYLEGUIDE)
* [Fork the project](https://github.com/nepalez/faceter)
* Create your feature branch (`git checkout -b my-new-feature`)
* Add tests for it
* Commit your changes (`git commit -am '[UPDATE] Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

Credits
-------

This project is heavily inspired by and based on two gems written by [Piotr Solnica](https://github.com/solnic):

* [rom](https://github.com/solic/rom) (Ruby Object Mapper)
* [transproc](https://github.com/solnic/transproc) Functional-style transformations in Ruby

License
-------

See the [MIT LICENSE](LICENSE).

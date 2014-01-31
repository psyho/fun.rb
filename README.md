# fun.rb

Making Ruby Fun(ctional) with first-order functions.

## Installation

Add this line to your application's Gemfile:

    gem 'fun'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fun

## Usage

### Automatic currying of Procs

```ruby
# Without fun.rb
sum = proc{|x,y| x + y}
inc = sum.curry[1]
inc[10] # = 11

# With fun.rb
sum = fn{|x,y| x + y}
inc = sum[1]
inc[10] # = 11
```

### Procs with anonymous arguments

```ruby
# Without fun.rb
inc = proc{ |x| x+1 }
mul = proc{ |x, y| x*y }

# With fun.rb
inc = f{it+1}
mul = f{a*b}
```

### Rich library of first-order functions

```ruby
string_or_symbol = any_pred[is_a[String], is_a[Symbol]]
filter(string_or_symbol, [1, :a, 2, "b"]) # = [:a, :b]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

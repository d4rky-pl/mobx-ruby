[![Build Status](https://travis-ci.org/d4rky-pl/mobx-ruby.svg?branch=master)](https://travis-ci.org/d4rky-pl/mobx-ruby) [![Coverage Status](https://coveralls.io/repos/github/d4rky-pl/mobx-ruby/badge.svg?branch=master)](https://coveralls.io/github/d4rky-pl/mobx-ruby?branch=master) [![Gem Version](https://badge.fury.io/rb/mobx-ruby.svg)](https://badge.fury.io/rb/mobx-ruby)

# Mobx-ruby

An implementation of MobX written in Ruby.

**THIS IS JUST A FUN PROJECT!!** It is *not* production ready.

## API

```
## Observables in classes

class ExampleClass
  include Mobx::Extension
  observable :foo, 123
end

example = ExampleClass.new

## Autorun

runner = Mobx.autorun do
  puts "Hello: #{example.foo}"
end

example.foo = 456
# > Hello: 456
example.foo = 789
# > Hello: 789

## Actions (transactions)

Mobx.action do
  example.foo = 123
  example.foo = 999
  example.foo = 1337
end
# > Hello: 1337

## Disposing of autoruns

runner.dispose

## Reactions

Mobx.reaction -> { example.foo } do
  puts "This doesn't look like anything to me"
end
# > This doesn't look like anything to me

example.foo = 333
# > This doesn't look like anything to me
```

## TODO

- observables are not infectious (observing an array or object will not trigger reactions, not sure how to handle this yet)
- naming conventions, I was experimenting too much and I'm not happy with the results

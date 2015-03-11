# capistrano-4ever

This gem provides some Capistrano3 tasks for deploying NodeJS servers using the
npm package Forever to make sure that that application runs forever.
The gem is named 'capistrano-4ever', as 'capistrano-forever' was taken (thus,
perhaps, rendering this gem redundant).  In any case, this gem namespaces under
'forever' instead of '4ever', and so the two gems are incompatible.

[Available via RubyGems](https://rubygems.org/gems/capistrano-4ever)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-4ever'
```

And then execute:

    % bundle

Or install it yourself as:

    % gem install capistrano-4ever

## Usage

Require in Capfile:
```ruby
require 'capistrano/forever'
```

### Configuration options to be set in deploy.rb
`:forever_env_variables` : Any environmental variables you'd like, as a hash.  I recommend setting `NODE_ENV` here.<br>
`:forever_path` : Path to globally installed forever binary.<br>
`:forever_app` : The application you're deploying.<br>
`:forever_target_path` : The target path.  Defaults to Capistrano's `release_path`.  I recommend that you don't set this.<br>
`:forever_flags` : Flags to pass to the forever binary as a string.
  * NB: **Order is important** here!  Ape the order in the example below or play around, but don't be frustrated if something that seems like it should work doesn't.  This is due to how the foreman binary parses options.

### Configuration defaults
Configuration symbol | Default
---------------|-----------------
`:forever_env_variables` | `{}`<br>
`:forever_path` | `'forever'` (let `env` take care of pathing)
`:forever_app` | `'main.js'`<br>
`:forever_target_path` | Capistrano's `release_path`<br>
`:forever_flags` | `'--append --uid <forever_app>'`

### Configuration recommendations
I recommend setting:<br>
  `-l` : So that you can have a shared logfile across deploys<br>
  `--append` : Append to logfiles and don't die when the logfile exists<br>
  `--minUptime` : If nothing else, keep NodeJS from complaing that you didn't set it.<br>
  `--spinSleepTime` : See above<br>
  `--uid <string>` : Set a custom string so that this gem will be able to stop previously-started instances.<br>
  
### Example
```ruby
set :forever_env_variables, {'NODE_ENV' => "#{fetch(:npm_env)}"}
set :forever_path, '/usr/bin/forever'
set :forever_app, 'dog-sitting-calendar.js'
set :forever_target_path, '/var/www/dogsit'
set :forever_flags, [ "-l #{fetch :forever_target_path}/log/forever.log",
                      '--append',
                      '--minUptime 1000',
                      '--spinSleepTime 1000',
                      "--uid '#{fetch :forever_app}'" ].join(' ')
```

### Custom tasks
```
% bundle exec cap <environment> forever:<task>
```
* `check` : Check for `forever` binary on deploy target
  * Displays human-readable output; not for scripting
* `start` : Start NodeJS server with forever
* `stop`: Stop NodeJS server with forever
* `restart` : Restart NodeJS server with forever
* `stop_all` : Stop all NodeJS servers managed by forever on target server
* `restart_all` : Restart all NodeJS servers managed by forever on target server

## Contributing

1. Fork it ( https://github.com/oversee-ffleming/capistrano-forever/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Added a neat feature!'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

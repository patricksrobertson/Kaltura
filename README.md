Kaltura
--------------
**Homepage**: [http://www.p-rob.me](http://www.p-rob.me)
**Author**: [Patrick Robertson](mailto:patricksrobertson@gmail.com)
**Copyright**: 2011
**License**: [MIT License](file:LICENSE.txt)

Build Status
------------

[![Build Status](https://secure.travis-ci.org/patricksrobertson/Kaltura.png?branch=master)](http://travis-ci.org/patricksrobertson/Kaltura?branch=master)

About Kaltura
-----------------

Kaltura is a Ruby API Wrapper for the Kaltura API.  It differentiates
itself from the Kaltura-Ruby library by the fact that it:

* Is actually tested if that's your bag (I know it's mine).
* Uses idiomatic Ruby
* Considerably lighter weight.

Currently, the following services are the only ones implemented:

* Session
* Media

Installation
------------
You can install the gem like so:

    gem install kaltura

If you are using rails, chuck that bitch in your Gemfile:

    gem "kaltura"


You can override some of the defaults in your config/initializers/ folder like so:

    #config/initializers/kaltura.rb
    MobilePath.configure do |config|
      config.partner_id = 12423
      config.adminsitrator_secret = 'somesecretstring'
      config.service_url = 'kaltura-ce.installed.url.com'
    end

Usage
-----

This thing is so easy to use!  It's why I made it.

If you need a specific Video:

    entry = Kaltura::MediaEntry.get('id')

If you need quite a few more:

    entries = Kaltura::MediaEntry.list

If you need to change it up:

    entry.update(:tags => "delicious, waffles")


Contributing to Kaltura
---------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2011 Patrick Robertson. See LICENSE.txt for
further details.


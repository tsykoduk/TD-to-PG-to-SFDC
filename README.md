# TD-to-PG-to-SFDC
Grab data from Treasure Data, move it to a staging table in postgres and then move to to SFDC via Heroku Connect

To install 

* ``git pull``
* ``heroku create``
* ``heroku addons:create treasure-data``
* ``heroku addons:create heroku-postgres``
* ``heroku addons:create herokuconnect``
* ``heroku run bundle exec rake --trace db:migrate`` or run the migrations by hand

Or click this button:


[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Notes:

* THIS USES NON-FREE ADDONS
* You will need a SFDC org that you can push data to
* currently you will need to use ```irb``` on a one-off dyno (ie, ```heroku run bash```) to call the methods.
* You will need to load the app into the irb session, ie ```require ./app.rb```
* You'll call ```get_from_td()``` first, and then ```put_int_sfdc()``` secondly. You should see the data flowing
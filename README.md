# TD-to-PG-to-SFDC
Grab data from Treasure Data, move it to a staging table in postgres and then move to to SFDC via Heroku Connect

To install 

``git pull``
``heroku create``
``heroku addons:create treasure-data``
``heroku addons:create heroku-postgres``
``heroku addons:create herokuconnect``

Or click this button:


[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

#Notes:

#THIS USES NON-FREE ADDONS
#You will need a SFDC org that you can push data to

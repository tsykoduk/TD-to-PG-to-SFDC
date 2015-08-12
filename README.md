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

To set up:

* You might upgrade to a production version of Heroku Connect (```heroku addons:upgrade herokuconnect:test```)
* On your SFDC instance, create a custom object called ```WwwAccess```
* In that object, create the following custom fields:
  * agent__c:  textarea
  * code__c: string
  * host__c: string
  * method__c: string
  * path__c: textarea
  * size__c: double
  * user__c: double
* Hook Heroku Connect up to sync that object and all of those custom fields
* Insure that you have the following tables in your Postgres Database:

	
		shrouded-plains-6761::DATABASE=> \dt 
		List of relations
		Schema     |       Name        | Type  |           
		------------+-------------------+-------+
		public      | wwwaccess         | table | 
		salesforce  | wwwaccess__c      | table | 
	

Notes:

* THIS USES NON-FREE ADDONS
* You will need a SFDC org that you can push data to
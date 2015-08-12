class  SfdcWwwAccess < ActiveRecord::Base

  self.table_name = "salesforce.wwwaccess__c"
  
  
 # name           | character varying(80)       | 
 # host__c        | character varying(255)      | 
 # sfid           | character varying(18)       | 
 # size__c        | double precision            | 
 # isdeleted      | boolean                     | 
 # systemmodstamp | timestamp without time zone | 
 # code__c        | character varying(255)      | 
 # user__c        | double precision            | 
 # id             | integer                     | not null default nextval('salesforce.wwwaccess__c_id_seq'::regclass)
 # _hc_lastop     | character varying(32)       | 
 # _hc_err        | text                        | 
 # method__c     | character varying(150)      | 
 # agent__c       | text                        | 
 # path__c        | text                        | 

end
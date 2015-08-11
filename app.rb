require 'bundler'
require 'action_view'
require 'active_record'
require 'uri'
require 'td'
require 'td-client'

Bundler.require


 set :database, ENV['DATABASE_URL'] || "LOCAL-POSTGRES-URL" 

 Dir["./models/*.rb"].each {|file| require file }


  def get_from_td() 
    cln = TreasureData::Client.new(ENV['TREASURE_DATA_API_KEY'] || "LOCAL-TD-API-KEY")
    job = cln.query('sample_datasets', 'SELECT * FROM www_access', result_url=nil, priority=nil, retry_limit=nil, :type => :presto)
    until job.finished?
      sleep 2
      job.update_progress!
    end
    job.update_status!  # get latest info
    i = 0
    job.result_each { |row| 
      put_into_pg(row[1],row[2],row[4],row[5],row[6], row[7])
      i = 1 + i
      puts "inserted row # " + i.to_s
     }
  end


  def put_into_pg(host, path, code, agent, size, method)
    foo = WwwAccess.new
    foo.host = host
    foo.path = path
    foo.code = code
    foo.agent = agent
    foo.size = size
    foo.method = method
    foo.save
  end
  
  def put_into_sfdc
    foos = WwwAccess.all
    foos.each do |foo|
      bar = SfdcWwwAccess.new
      bar.host__c = foo.host
      bar.path__c = foo.path
      bar.code__c = foo.code
      bar.agent__c = foo.agent
      bar.size__c = foo.size
      bar.method__c = foo.method
      bar.save!
    end
  end
  
  def clean_sfdc()
    rec = SfdcWwwAccess.all
    rec.each do |r|
      r.delete
    end
  end
  
  def clean_td_data()
    rec = WwwAccess.all
    rec.each do |r|
      r.delete
    end
  end
  
  
  def put_into_mysql()
    
  end


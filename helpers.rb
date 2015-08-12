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
     i = 1 + i
     if i < 501
       put_into_pg(row[1],row[2],row[4],row[5],row[6], row[7])
       puts "inserted row # " + i.to_s
     end
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
   i = 0
   foos.each do |foo|
     i = i + 1
     bar = SfdcWwwAccess.new
     bar.host__c = foo.host
     bar.path__c = foo.path
     bar.code__c = foo.code
     bar.agent__c = foo.agent
     bar.size__c = foo.size
     bar.method__c = foo.method
     bar.save!
     puts "moved row #" + i.to_s + " into SFDC"
   end
 end
 
 def clean_sfdc()
   rec = SfdcWwwAccess.all
   i = 0
   rec.each do |r|
     i = i +1
     r.delete
     puts "removed record #" + i.to_s      
   end
 end
 
 def clean_td()
   rec = WwwAccess.all
   i = 0
   rec.each do |r|
     i = i +1
     r.delete
     puts "removed record #" + i.to_s
   end
 end
 
 
 def put_into_mysql()
   #what if we want to move the data to MySQL or some other datastore? How about we do that here?
 end

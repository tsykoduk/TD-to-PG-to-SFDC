require 'bundler'
require 'action_view'
require 'active_record'
require 'uri'
require 'td'
require 'td-client'

Bundler.require

require "./helpers.rb"

class App < Sinatra::Base
  
  get "/" do
    @td_count = WwwAccess.all.count
    @sfdc_count = SfdcWwwAccess.all.count
    erb :index
  end
  
  get "/pull-from-td" do
    pull_from_td()
    redirect to('/')  
  end
  
  get "/put-into-sfdc" do
    put_into_sfdc()
    redirect to('/')
  end
  
  
  
end
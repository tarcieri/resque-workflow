$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'foreman'
require 'rspec'

database = "test.sqlite3"
File.delete database if File.exist? database
ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => database
                                        
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define(:version => 1) do
  create_table :cats, :force => true do |t|
    t.string :workflow_state
    t.string :name
    t.string :mood, :default => 'fiesty'
  end
end
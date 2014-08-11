require 'rspec'
require 'pg'
require 'pry'
require 'wallet'
require 'category'
require 'company'
require 'expense'
require 'purchase_date'


DB = PG.connect({:dbname => 'expense_tracker_test'})
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM companys *;")
    DB.exec("DELETE FROM categorys *;")
    DB.exec("DELETE FROM purchase_dates *;")
    DB.exec("DELETE FROM expenses *;")
  end
end

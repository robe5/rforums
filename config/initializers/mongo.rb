environment = {
  :development => {
    :host => 'localhost',
    :port => 27088,
    :database => 'forums',
    :user => 'admin',
    :password => '1234'
  },
  :production => {
    :host => 'flame.mongohq.com',
    :port => 27088,
    :database => 'forums',
    :user => 'admin',
    :password => 'likeafriend'
  }
}

MongoMapper.connection = Mongo::Connection.new('flame.mongohq.com', 27088, {:logger => Rails.logger})
MongoMapper.database = 'forums'
MongoMapper.database.authenticate('admin', 'likeafriend')

require 'bcrypt'
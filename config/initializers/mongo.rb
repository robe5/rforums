require 'bcrypt'
#config = YAML.load_file(Rails.root.join('config', 'database.yml'))
#MongoMapper.setup(config, Rails.env, {:logger => Rails.logger, :passenger => false})
config = YAML.load_file(Rails.root.join('config', 'mongo.yml'))[Rails.env]
MongoMapper.connection = Mongo::Connection.new(config['host'], config['port'], {:logger => Rails.logger})
MongoMapper.database = config['database']

if config['authentication']
  MongoMapper.database.authenticate(config['user'], config['password'])
end

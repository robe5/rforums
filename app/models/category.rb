class Category
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :description, String
  key :position, Integer, :default => 0
  
  key :user_id,   ObjectId
  
  # Relationships
  belongs_to :user
  many :topics  
end

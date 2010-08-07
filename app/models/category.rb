class Category
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :description, String
  
  key :user_id,   ObjectId
  
  # Relationships
  belongs_to :user
  many :topics  
end
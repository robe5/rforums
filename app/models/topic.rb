class Topic
  include MongoMapper::Document
  key :title, String, :required => true
  key :text, String, :required => true
  timestamps!
  
  # cached values
  key :post_count,  Integer, :default => 0
  key :user_name, String
  
  # Relationships
  belongs_to :user
  belongs_to :category
  many :posts
  
  # Validations
  validates_presence_of :user_id
  
  # Callbacks
  before_create :cache_user_name
    
  def level
    0
  end

  def increment_post
    self.increment({:post_count => 1})
  end
  
  def decrement_post
    self.decrement({:post_count => 1})
  end
  
  private
  def cache_user_name
    self.user_name = user.name
  end  
end
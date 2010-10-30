class Item
  include MongoMapper::Document
  
  key :text, String, :required => true
  timestamps!
  
  # Cached Values
  key :user_name, String
  
  # Relationships
  belongs_to :user
  
  # Validations
  validates_presence_of :user_id

  # Callbacks
  before_create :cache_user_name  
                                
  def self.recent(limit = 10)
    limit(limit).order('created_at DESC').all
  end

  private
  def cache_user_name
    self.user_name = user.name
  end  
end
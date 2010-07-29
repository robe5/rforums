class Post
  include MongoMapper::Document  
  key :text, String, :required => true
  timestamps!

  # cached values
  key :user_name, String
  
  # Relationships
  belongs_to :topic
  belongs_to :user

  # Validations
  validates_presence_of :user_id
  
  # Callbacks
  before_create :cache_user_name
  after_create :increment
  after_destroy :decrement

  private
  def cache_user_name
    self.user_name = user.name
  end
  
  def increment
    self.topic.increment_post
  end

  def decrement
    self.topic.decrement_post
  end
end
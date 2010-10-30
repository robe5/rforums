class Post < Item
  
  # Relationships
  belongs_to :topic
  
  # Validations
  validates_presence_of :topic_id
  
  # Callbacks
  after_create :increment, :increment_user_posts
  after_destroy :decrement, :decrement_user_posts
  
  private  
  # increments topics posts counter
  def increment
    topic.increment(1)
  end

  def decrement
    topic.increment(-1)
  end
  
  # increments user topics counter
  def increment_user_posts
    user.increment_posts(1)
  end
  
  def decrement_user_posts
    user.increment_posts(-1)
  end
end
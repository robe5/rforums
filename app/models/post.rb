class Post < Item
  
  # Relationships
  belongs_to :topic
  
  # Callbacks
  after_create :increment
  after_destroy :decrement
  
  private  
  def increment
    topic.increment(1)
  end

  def decrement
    topic.increment(-1)
  end
end
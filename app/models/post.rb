class Post < Item
  
  # Relationships
  belongs_to :topic
  
  # Validations
  validates_presence_of :topic_id
  
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
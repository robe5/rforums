class Topic < Item
  key :title, String, :required => true
  
  # cached values
  key :post_count,  Integer, :default => 0
  
  # Relationships
  belongs_to :category
  many :posts

  # Validations
  validates_presence_of :category_id

  def last_post_id
    @last_post_id ||= (posts.size > 0 ? posts.last.id : id)
  end

  def last_user_name
    @last_user_name ||= (posts.size > 0 ? posts.last.user_name : user_name)
  end
  
  def level
    0
  end

  def increment(n = 1)
    return false unless n.is_a? Numeric
    Topic.collection.update({:_id => self.id},
      { "$inc" => {:post_count => n}, 
        "$set" => {:updated_at => Time.now}
      })
  end
end
class Topic < Item
  key :title, String, :required => true
  
  # cached values
  key :post_count,  Integer, :default => 0
  
  # Relationships
  belongs_to :category
  many :posts
        
  # TODO: Cachear esto
  def last_user_name
    if posts.size > 0
      posts.last.user_name
    else
      user_name
    end
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
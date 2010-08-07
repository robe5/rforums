module ApplicationHelper
  def breadcrumps
    links = [['HOME', root_path]]
    if @category
      if @category.new_record?
        links << ["New category", new_category_path]
      else
        links << [@category.name, @category]
      end
    end
    if @topic
      if @topic.new_record?
        links << ["New topic", new_category_topic_path(@category)]
      else
        links << [@topic.title, [@category, @topic]]
      end
    end
    links.map{|link| link_to link.first, link.last }
  end
  
  def item_path(item)
    case item.class.to_s
    when "Topic"
      [@category, item]
    when "Post"
      [@category, @topic, item]
    else
      "#"
    end
  end
  
  def gravatar(email, size = nil)
    url = "http://www.gravatar.com/avatar/"
    hash = Digest::MD5.hexdigest(email.downcase).to_s
    param = "?s=#{size}" if size
    [url, hash, param].join
  end
end

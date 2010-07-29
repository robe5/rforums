module ApplicationHelper
  def breadcrumps
    links = [['HOME', root_path]]
    if @category
      links << [@category.name, @category]
    end
    if @topic
      if @topic.new_record?
        links << ["New topic", [@category, new_topic_path]]
      else
        links << [@topic.title, [@category, @topic]]
      end
    end
    links.map{|link| link_to link.first, link.last }
  end
end

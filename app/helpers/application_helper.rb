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

    if @users
      links << ["Users", users_path]
    end
    
    if @user
      links << ["Users", users_path]
      links << [@user.name, @user]
    end
    
    links.map do |link| 
      if links.size > 1 && link == links.last
        link.first
      else
        link_to link.first, link.last
      end
    end
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

  def edit_item_path(item)
    case item.class.to_s
    when "Topic"
      ['edit', @category, item]
    when "Post"
      ['edit', @category, @topic, item]
    else
      '#'
    end
  end

  def paginator(object, opts = {})
    return unless object.respond_to?(:paginator)
    paginator = object.paginator
    parts = []
    1.upto(paginator.total_pages) do |page|
      if page == paginator.current_page
        parts << content_tag(:span, page, :class => 'page current')
      else
        parts << content_tag(:span, link_to(page, "?page=#{page}"), :class => 'page')
      end
    end
    parts.unshift content_tag(:span, link_to('Preview', "?page=1"), :class => 'page') unless paginator.current_page == 1
    parts << content_tag(:span, link_to('Next', "?page=#{paginator.total_pages}"), :class => 'page') unless paginator.current_page == paginator.total_pages
    parts.join("").html_safe
  end

  def markdown(text)
    return unless text.present?
    RDiscount.new(gfm(text)).to_html.html_safe
  end
  
  def gravatar(email, size = nil)
    url = "http://www.gravatar.com/avatar/"
    hash = Digest::MD5.hexdigest(email.downcase).to_s
    param = "?s=#{size}" if size
    [url, hash, param].join
  end
  
  def user_signature(user)
    if user.signature.present?
      user.signature
    else
      user.name
    end
  end

  def analytics
    return unless Rails.env == 'production'
    render :partial => 'shared/analytics'
  end
end

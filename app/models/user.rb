# uses bcrypt-ruby gem for password hashing be sure to config.gem it
require 'digest/sha1'
require 'bcrypt'
class User      
  include MongoMapper::Document
  
  # info
  key :email,     String, :required => true
  key :name,      String, :required => true
  key :signature, String
  
  # stats
  key :topics_count,  Integer, :default => 0
  key :posts_count,   Integer, :default => 0
  
  # security
  key :admin, Boolean
  key :crypted_password, String
  key :reset_password_code, String
  key :reset_password_code_until, Time
  
  timestamps!

  RegEmailName   = '[\w\.%\+\-]+'
  RegDomainHead  = '(?:[A-Z0-9\-]+\.)+'
  RegDomainTLD   = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  RegEmailOk     = /\A#{RegEmailName}@#{RegDomainHead}#{RegDomainTLD}\z/i
  
  def self.authenticate(email, secret)
    u = User.first(:conditions => {:email => email.downcase})
    u && u.authenticated?(secret) ? u : nil
  end
  
  validates_length_of :email, :within => 6..100, :allow_blank => true
  validates_format_of :email, :with => RegEmailOk, :allow_blank => true
  validates_uniqueness_of :email
  
  PasswordRequired = Proc.new { |u| u.password_required? }
  validates_presence_of :password, :if => PasswordRequired
  validates_confirmation_of :password, :if => PasswordRequired, :allow_nil => true
  validates_length_of :password, :minimum => 6, :if => PasswordRequired, :allow_nil => true
  
  before_create :create_admin
  after_update :update_items_cache
  
  def authenticated?(secret)
    BCrypt::Password.new(crypted_password) == secret ? true : false
  end
  
  def password
    @password
  end
  
  def password=(value)
    if value.present?
      @password = value
      self.crypted_password = BCrypt::Password.create(value)
    end
  end
  
  def password_confirmation
    @password_confirmation
  end
  
  def password_confirmation=(value)
    if value.present?
      @password_confirmation = value
    end
  end
  
  def email=(new_email)
    new_email.downcase! unless new_email.nil?
    write_attribute(:email, new_email)
  end
  
  def role
    admin ? 'admin' : 'member'
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  def set_password_code!
    seed = "#{email}#{Time.now.to_s.split(//).sort_by {rand}.join}"
    self.reset_password_code_until = 1.day.from_now
    self.reset_password_code = Digest::SHA1.hexdigest(seed)
    save!
  end
  
  private
  def create_admin
    self.admin = true if User.count == 0
  end
  
  def update_items_cache
    Item.collection.update({:user_id => self.id}, "$set" => {"user_name" => self.name})
  end
  
  def increment_topics(n = 1)
    User.collection.update({:_id => self.id},
      { "$inc" => {:topics_count => n}
      })
  end

  def increment_posts(n = 1)
    User.collection.update({:_id => self.id},
      { "$inc" => {:posts_count => 1}
      })
  end
end

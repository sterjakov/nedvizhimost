class User < ActiveRecord::Base

  attr_accessible :name, :password, :role, :password_key, :action, :auth_token, :user_id, :salt
  attr_accessor :password_key, :action

  validates :name, :password_key, :role, presence: true, if: "self.action == 'create'"
  validates :name, :password_key,    presence: true, if: "self.action == 'login'"

  before_save :set_password

  has_many :posts

  ROLES = [ ['Администратор', 0], ['Автор', 1], ]

  def no_admin?
    self.role > 0
  end

  def get_role
    ROLES.each { |k,v| return k if v = self.role }
  end

  def generate_salt
    (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def generate_password(password_key, salt)
    Digest::MD5.hexdigest(password_key + salt)
  end

  def set_password
    if self.password_key.present?
      self.salt = generate_salt
      self.password = generate_password(self.password_key, self.salt)
    end
  end

  def verify_password_key(password_key)
    generate_password(password_key, self.salt) == self.password
  end

  def generate_auth_token
    self.auth_token = BCrypt::Password.create(self.password + self.salt + self.updated_at.to_s)
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :ldap_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  attr_accessor :login
  
  enum role:{
    user: 0,
    admin: 1,
    superadmin: 2
  }

  validates :username,
    :uniqueness => {
      :case_sensitive => false
    }, :allow_nil => true
  validates_format_of :username, with: /^[a-zA-Z0-9_\-\.]*$/, :multiline => true
  validate :validate_username
  validate :validate_not_dvfu_email, unless: :allow_dvfu_email


  

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def validate_not_dvfu_email
    if /^.+?@(students\.|)dvfu.ru$/i === email
      errors.add(:email, 'Нельзя регистрироваться под учетной записью ДВФУ. Вам необходимо войти под ней.')
    end
  end

  def allow_dvfu_email
    return self.ldap_user
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end  

  def is_admin?
    self.superadmin? || self.admin?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end  

  def send_reset_password_instructions
    if self.ldap_user
      errors.add(:email, 'для восстановления пароля учетной записи ДВФУ перейдите по ссылке: https://idm.dvfu.ru/component/userpanel/recovery')
      return false 
    end
    super
  end 
end

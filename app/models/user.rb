class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :username, :password, :password_confirmation, :email

  before_create :set_authentication_token

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_presence_of :email
  validates_uniqueness_of :email

  def set_authentication_token
    self.authentication_token = Digest::MD5.hexdigest(self.salt) 
  end

end

class User < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password_hash
  validates_presence_of :password_salt

  has_many :pictures, :dependent => :destroy

end

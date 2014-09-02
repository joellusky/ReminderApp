class User < ActiveRecord::Base
# Setup accessible (or protected) attributes for your model
#attr_accessible :first_name, :last_name, :cell_phone, :email, :password, :password_confirmation

  has_many :bills
  #has_many :providers
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

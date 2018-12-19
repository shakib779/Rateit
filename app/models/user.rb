class User < ApplicationRecord
  
	has_many :books
	has_many :movies
	has_many :songs
	has_many :dramas

  has_many :bookreps
  
  has_one :bookreview
  has_one :moviereview
  has_one :songreview
  has_one :dramareview
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :set_user_name

  private
    def set_user_name
       self.user_name = self.nickname + self.id.to_s;
    end

end

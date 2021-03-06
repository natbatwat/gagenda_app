class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  before_create :set_default_role

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end

  has_many :courses, through: :courses_users
  has_many :courses_users
  validates :email, uniqueness: true
  mount_uploader :user_image, UserImageUploader

end

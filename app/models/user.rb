class User < ActiveRecord::Base
  extend FriendlyId
  has_merit

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable

  validates :username, presence: true, unless: -> {self.provider == 'facebook'}
  validates :username, uniqueness: true, if: -> { self.username.present? }

  has_many :user_roles
  has_many :roles, -> { select 'roles.*, user_roles.cliq_id AS cliq_id' }, :through => :user_roles

  delegate :can?, :cannot?, :to => :ability

  has_many :topics
  has_many :replies
  has_many :favorites
  has_many :bookmarks

  friendly_id :username, use: :slugged

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_admin
    self.roles << Role.admin
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    data = auth['info']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(uid: auth['uid'], provider: auth['provider'], :email => data["email"], first: data["first_name"], last: data["last_name"], :password => Devise.friendly_token[0,20])
    end
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.disable_signup?
    !!ENV['DISABLE_SIGNUP']
  end

  devise(:registerable) unless disable_signup?

  GRAVATAR_URL = 'http://www.gravatar.com/avatar/'

  def avatar_url(size: 25)
    "#{GRAVATAR_URL}#{gravatar_digest}.jpg?s=#{size}"
  end

  private

  def gravatar_digest
    Digest::MD5.hexdigest(email.downcase.strip)
  end
end

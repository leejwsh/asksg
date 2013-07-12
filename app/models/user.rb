# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers,   dependent: :destroy

  has_reputation :questioning_skill, source: { reputation: :votes, of: :questions }
  has_reputation :answering_skill, source: { reputation: :votes, of: :answers }

  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  def reputation
    # This is a hack, since
    #
    # has_reputation :karma, source: [{ reputation: :questioning_skill },
    #                                 { reputation: :answering_skill }]
    # reputation_for(:karma)
    #
    # is bugged.
    reputation_for(:questioning_skill).to_i + reputation_for(:answering_skill).to_i
  end

  def votes_cast
    Question.evaluated_by(:votes, self).count + Answer.evaluated_by(:votes, self).count
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

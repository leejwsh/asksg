class Question < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true

  default_scope order: 'questions.created_at DESC'
end

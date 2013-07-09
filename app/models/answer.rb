# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question
  belongs_to :user

  validates :user_id, 	  presence: true
  validates :question_id, presence: true
  validates :content, 	  presence: true

  default_scope order: 'answers.created_at DESC'
end

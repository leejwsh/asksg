# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#

class Question < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :user

  validates :user_id, presence: true
  validates :title,   presence: true
  validates :content, presence: true

  default_scope order: 'questions.created_at DESC'
end

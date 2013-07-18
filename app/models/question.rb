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
  attr_accessible :title, :content, :tag_list
  acts_as_taggable

  belongs_to :user
  has_many :answers, dependent: :destroy

  has_reputation :votes, source: :user

  validates :user_id,  presence: true
  validates :title,    presence: true
  validates :content,  presence: true
  validates :tag_list, presence: true

  default_scope order: 'questions.created_at DESC'

  def self.search(search)
    if search
      search_length = search.split.uniq.length
      select("questions.*").joins(:base_tags).where([(['(title LIKE ? OR content LIKE ? OR tags.name = ?)'] * search_length).join(' AND ')] + search.split.uniq.map { |word| ["%#{word}%"] * 2 + [word] }.reduce(:+)).group("questions.id")
      #select("DISTINCT questions.*").joins(:base_tags).where("questions.title LIKE ? OR questions.content LIKE ? OR tags.name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      find(:all)
    end
  end
end
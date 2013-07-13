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

require 'spec_helper'

describe Question do
  let(:user) { FactoryGirl.create(:user) }
  before { @question = FactoryGirl.create(:question, user: user) }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Question.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @question.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @question.title = " " }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @question.content = " " }
    it { should_not be_valid }
  end

  describe "answer associations" do

    before { @question.save }
    let!(:a1) { FactoryGirl.create(:answer, user: user, question: @question) }
    let!(:a2) { FactoryGirl.create(:answer, user: user, question: @question) }

    it "should destroy associated answers" do
      answers = @question.answers.dup
      @question.destroy
      answers.should_not be_empty
      answers.each do |answer|
        Answer.find_by_id(answer.id).should be_nil
      end
    end
  end
end

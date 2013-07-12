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

require 'spec_helper'

describe Answer do
  let(:user)     { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question) }
  before { @answer = FactoryGirl.create(:answer, user: user, question: question) }

  subject { @answer }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:question_id) }
  it { should respond_to(:question) }
  its(:user) { should == user }
  its(:question) { should == question }

  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Answer.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

     it "should not allow access to question_id" do
      expect do
        Answer.new(question_id: question.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @answer.user_id = nil }
    it { should_not be_valid }
  end

  describe "when question_id is not present" do
    before { @answer.question_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @answer.content = " " }
    it { should_not be_valid }
  end
end
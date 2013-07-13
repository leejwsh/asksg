require 'spec_helper'

describe "Answer pages" do

  describe "edit page" do

    subject { page }

    let(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question, user: user) }
    let!(:answer) { FactoryGirl.create(:answer, user: user, question: question) }

    before { visit edit_answer_path(answer) }

  end
end
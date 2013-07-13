require 'spec_helper'

describe "Question page" do

  subject { page }

  let(:asker) { FactoryGirl.create(:user) }
  let(:answerer) { FactoryGirl.create(:user) }
  let(:onlooker) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question, user: asker) }
  let!(:answer) { FactoryGirl.create(:answer, user: answerer, question: question) }

  before { visit question_path(question) }

  it { should have_selector('h1',    text: question.title) }
  it { should have_selector('title', text: full_title(question.title)) }

  describe "question" do
    it { should have_content(question.content) }
    it { should have_content(question.reputation_for(:votes).to_i) }

    it { should_not have_link("up", href: vote_question_path(question, type: "up")) }
    it { should_not have_link("down", href: vote_question_path(question, type: "down")) }

    describe "hash tags" do
      before { click_link question.tag_list.first }
      it { should have_content("Results for ##{question.tag_list.first}") }
    end

    describe "asker" do
      before { click_link asker.name }
      it { should have_selector('title', text: full_title(asker.name)) }
    end
  end

  describe "answers" do
    it { should have_content(question.answers.count) }
    it { should have_content(answer.content) }
    it { should have_content(answer.reputation_for(:votes).to_i) }

    describe "answerer" do
      before { click_link answerer.name }
      it { should have_selector('title', text: full_title(answerer.name)) }
    end
  end

  describe "signed in as onlooker" do
    before do
      sign_in(onlooker)
      visit question_path(question)
    end

    it { should have_link("up", href: vote_question_path(question, type: "up")) }
    it { should have_link("down", href: vote_question_path(question, type: "down")) }
    it { should have_link("up", href: vote_answer_path(answer, type: "up")) }
    it { should have_link("down", href: vote_answer_path(answer, type: "down")) }
  end
end
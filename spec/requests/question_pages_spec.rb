require 'spec_helper'

describe "Question pages" do

  describe "content page" do

    subject { page }

    let(:asker) { FactoryGirl.create(:user) }
    let(:answerer) { FactoryGirl.create(:user) }
    let(:onlooker) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question, user: asker) }
    let!(:answer) { FactoryGirl.create(:answer, user: answerer, question: question) }

    before { visit question_path(question) }

    it { should have_selector('h1',    text: question.title) }
    it { should have_selector('title', text: full_title(question.title)) }

    it { should_not have_link("delete") }

    describe "question section" do
      it { should have_content(question.content) }
      it { should have_content(question.reputation_for(:votes).to_i) }

      it { should_not have_link("up", href: vote_question_path(question, type: "up")) }
      it { should_not have_link("down", href: vote_question_path(question, type: "down")) }

      describe "hash tags" do
        before { click_link question.tag_list.first }
        it { should have_content("Results for ##{question.tag_list.first}") }
      end

      describe "link to asker" do
        before { click_link asker.name }
        it { should have_selector('title', text: full_title(asker.name)) }
      end
    end

    describe "answers section" do
      it { should have_content(question.answers.count) }
      it { should have_content(answer.content) }
      it { should have_content(answer.reputation_for(:votes).to_i) }

      it { should_not have_link("up", href: vote_answer_path(answer, type: "up")) }
      it { should_not have_link("down", href: vote_answer_path(answer, type: "down")) }

      describe "link to answerer" do
        before { click_link answerer.name }
        it { should have_selector('title', text: full_title(answerer.name)) }
      end
    end

    describe "signed in as asker" do
      before do
        sign_in(asker)
        visit question_path(question)
      end

      it { should_not have_link("up", href: vote_question_path(question, type: "up")) }
      it { should_not have_link("down", href: vote_question_path(question, type: "down")) }
      it { should have_link("up", href: vote_answer_path(answer, type: "up")) }
      it { should have_link("down", href: vote_answer_path(answer, type: "down")) }
      #it { should have_link("edit", href: <insert edit question path>) }

      it "should allow question to be deleted" do
        expect { click_link "delete" }.to change(Question, :count).by(-1)
      end
    end

    describe "signed in as answerer" do
      before do
        sign_in(answerer)
        visit question_path(question)
      end

      it { should have_link("up", href: vote_question_path(question, type: "up")) }
      it { should have_link("down", href: vote_question_path(question, type: "down")) }
      it { should_not have_link("up", href: vote_answer_path(answer, type: "up")) }
      it { should_not have_link("down", href: vote_answer_path(answer, type: "down")) }
      #it { should have_link("edit", href: <insert edit answer path>) }

      it "should allow answer to be deleted" do
        expect { click_link "delete" }.to change(Answer, :count).by(-1)
      end
    end
  end
end
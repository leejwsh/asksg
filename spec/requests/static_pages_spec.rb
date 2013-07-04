require 'spec_helper'

describe "Static Pages" do

  subject { page }
  
  describe "Home page" do
    before { visit root_path }

    it { should have_selector('title', text: full_title('')) }
    it { should have_selector('h1',    text: "AskSG") }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('title', text: full_title('About')) }
    it { should have_selector('h1',    text: "About") }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Sign up"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link full_title('')
    page.should have_selector 'h1', text: full_title('')
  end  
end
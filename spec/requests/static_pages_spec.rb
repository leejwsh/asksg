require 'spec_helper'

describe "Static Pages" do

  subject { page }
  
  describe "Home page" do
    before { visit root_path }

    it { should have_selector('title', text: "Ask SG") }
    it { should have_selector('h1',    text: "Ask SG") }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('title', text: "Ask SG | About") }
    it { should have_selector('h1',    text: "About") }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Sign up"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "ask sg"
    page.should have_selector 'h1', text: "Ask SG"
  end  
end
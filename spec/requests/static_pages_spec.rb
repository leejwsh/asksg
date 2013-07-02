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
end
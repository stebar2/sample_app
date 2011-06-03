require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_title + " | About")
    end
  end
  
  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content =>  @base_title + " | Contact")
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                                    :content =>  @base_title + " | Help")
    end
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content =>  @base_title + " | Home")
    end
    
    describe 'for signed-in users' do
      
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      
      it "should display plural '0 microposts' in sidebar" do
        get 'home'
        response.should have_selector('span.microposts', :content => '0 microposts')
      end
      
      it "should display singular '1 micropost' in sidebar" do
        mps = [ Factory(:micropost, :user => @user) ]
        get 'home'
        response.should have_selector('span.microposts', :content => '1 micropost')
        response.should_not have_selector('span.microposts', :content => '1 microposts')
      end
      
      it 'should paginate microposts' do
        mps = [ ]
        31.times do
          mps << Factory(:micropost, :user => @user)
        end
        
        get 'home'
        response.should have_selector('div.pagination')
        response.should have_selector('span.disabled', :content => 'Previous')
        response.should have_selector('a', :href => '/?page=2', :content => '2')
        response.should have_selector('a', :href => '/?page=2', :content => 'Next')
      end
    end
  end
end

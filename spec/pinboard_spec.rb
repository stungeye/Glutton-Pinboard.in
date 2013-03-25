require_relative './spec_helper.rb'

describe GluttonPinboard do
  before do
    @pinboard = GluttonPinboard.new 'username:NO_NEED_FOR_TOKEN_WHEN_TESTING'
  end
  
  describe "when asked for its class" do
    it "must response with GluttonPinboard" do
      @pinboard.class.must_equal GluttonPinboard
    end
  end
  
  describe "when asked to fetch all posts" do
    
    stub_get(%r|https://api\.pinboard\.in/v1/posts/all|, "all_posts.xml")
    
    it "must respond with an array of posts of a specific size" do
      all_posts = @pinboard.posts_all
      all_posts.class.must_equal Array
      all_posts.size.must_equal 1262
    end
  end
end

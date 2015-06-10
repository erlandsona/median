feature "List only has twenty items per page" do
  # The search result pages only shoe 20 entries per page.
  describe "limited showing of posts" do
    before(:each) do
      # PostsController.set_instance_variable(@per, 20)
    end

    scenario "posts list" do
      me = Fabricate(:user, name: "Jim-Bob")
      signin_as me
      visit index_posts_path
      page.should have_css('.pagination')
    end
  end
end

feature "List only has twenty items per page" do
  # The search result pages only shoe 20 entries per page.
  describe "limited showing of posts" do
    before do
      PostsController.set_instance_variable(@per, 20)
    end

    scenario "posts list" do
      page.should have_selector('div.pagination')
    end
  end
end

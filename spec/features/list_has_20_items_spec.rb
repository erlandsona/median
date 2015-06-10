feature "List only has twenty items per page" do
  # The search result pages only shoe 20 entries per page.
  describe "limited showing of posts" do

    before(:each) do
      # PostsController.set_instance_variable(@per, 20)
    end

    scenario "posts list happy path" do
      me = Fabricate(:user)
      30.times do
        Fabricate(:post, author: me)
      end
      signin_as me
      render_template layout: "users/index"
      visit user_posts_path(me)
      page.should have_css('ul.pagination')
      within("ul.pagination") do
        page.should have_css("li:nth-child(1)")
        page.should_not have_css("li:nth-child(21)")
      end
      page.should have_link("2")
      click_link "2"
      within("ul.pagination") do
        page.should have_css("li:nth-child(9)")
        page.should have_css("li:nth-child(10)")
        page.should_not have_css("li:nth-child(11)")
      end
    end
  end
end

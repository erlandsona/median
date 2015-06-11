feature "List only has twenty items per page" do
  scenario "posts list has 20 posts per page" do
    me = Fabricate(:user)
    15.times do
      Fabricate(:post, author: me)
    end
    signin_as me
    render_template layout: "users/index"
    visit user_posts_path(me)
    page.should have_css('ul.posts-pagination')
    within("ul.posts-pagination") do
      page.should have_css("li:nth-child(5)")
      page.should_not have_css("li:nth-child(6)")
    end
    page.should have_link("2")
    click_link "2"
    within("ul.posts-pagination") do
      page.should have_css("li:nth-child(4)")
      page.should have_css("li:nth-child(5)")
      page.should_not have_css("li:nth-child(6)")
    end
  end

  scenario "user list has 20 users per page" do
    9.times do
      Fabricate(:user)
    end
    me = Fabricate(:user)
    signin_as me
    render_template layout: "users/index"
    within("ul.user_pagination") do
      page.should have_css("li:nth-child(1)")
      page.should_not have_css("li:nth-child(6)")
    end
    click_link "2"
    within("ul.user_pagination") do
      page.should have_css("li:nth-child(4)")
      page.should have_css("li:nth-child(5)")
      page.should_not have_css("li:nth-child(6)")
    end
  end
end

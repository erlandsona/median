feature "user creates comment" do
  # As a comment-poster,
  # In order to share my comments to the post,
  # I want to publish a comment
  # Acceptance Criteria:
  # * Comment must have a body
  # * Comment must be publicly visible once saved

  scenario "logged out users can't create comments" do
    visit root_path
    page.should_not have_content("Share Some Knowledge")
    visit new_post_path
    should_be_denied_access
  end

  scenario "happy path" do
    me = Fabricate(:user, name: "Bob")
    entry = Fabricate(:post, title: "Tom's Post")
    author = entry.author
    signin_as me
    click_on "#{@author}'s Knowledge"
    page.should have_content("#{@author}'s Post")
    click_on "Tom's Post"
    current_path.should == user_posts_path(entry)
    fill_in "Body", with: "Here is my comment to you, Tom."
    click_on "Submit Comment"
    page.should have_notice("Your comment has been published")
    current_path.should == user_posts_path(entry)
    page.should have_css(".comment", text: "Here's my comment to you, Tom.")
   end

  scenario "sad path" do
    me = Fabricate(:user, name: "Bob")
    signin_as me
    click_on "Share Some Knowledge"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_on "Publish Knowledge"
    page.should have_alert("Your knowledge could not be published. Please correct the errors below.")
    page.should have_error("can't be blank", on: "Title")
    page.should have_error("can't be blank", on: "Body")
  end
end

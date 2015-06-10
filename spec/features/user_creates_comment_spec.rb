feature "user creates comment" do

  let(:julie){ Fabricate(:user, name: "Julie") }

  background do
    bob = Fabricate(:user, name: "Bob")
    ingrid = Fabricate(:user, name: "Ingrid")
    Fabricate(:post, author: bob, title: "Bob's Burger Recipe")
    Fabricate(:post, author: julie, title: "Julie's Intro to XPath", body: "XPath is *great*")
    Fabricate(:post, author: julie, title: "Julie's Over XPath", body: "XPath is *great*")
    visit root_path
  end

  # As a comment-poster,
  # In order to share my comments to the post,
  # I want to publish a comment
  # Acceptance Criteria:
  # * Comment must have a body
  # * Comment must be publicly visible once saved

  # scenario "logged out users can't create comments" do
  #   visit root_path
  #   page.should_not have_content("Share Some Knowledge")
  #   visit new_post_path
  #   should_be_denied_access
  # end

  scenario "happy path" do
    me = Fabricate(:user, name: "Bob")
    signin_as me
    click_on "Bob's Knowledge"
    page.should have_content("Bob's Burger Recipe")
    click_on "Bob's Burger Recipe"
    page.should have_css("h1", text: "Bob's Burger Recipe")
    save_and_open_page
    fill_in "Body", with: "Here is my comment to you, Tom."
    click_on "Publish Comment"
    page.should have_notice("Your comment has been published")
    current_path.should == user_posts_path(entry)
    page.should have_css(".comment", text: "Here's my comment to you, Tom.")
   end

  # scenario "sad path" do
  #   pending
  #   me = Fabricate(:user, name: "Bob")
  #   signin_as me
  #   click_on "Share Some Knowledge"
  #   fill_in "Title", with: ""
  #   fill_in "Body", with: ""
  #   click_on "Publish Knowledge"
  #   page.should have_alert("Your knowledge could not be published. Please correct the errors below.")
  #   page.should have_error("can't be blank", on: "Title")
  #   page.should have_error("can't be blank", on: "Body")
  # end
end

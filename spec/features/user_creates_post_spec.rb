feature "user creates post" do
  # As a user
  # In order to share my thoughts with the world
  # I want to publish a blog post

  # Acceptance Criteria:
  # * Post must have title and body
  # * Post must be publicly visible once saved

  background do
    pending
  end

  scenario "logged out users can't create posts" do
    visit root_path
    page.should_not have_content("Share Some Knowledge")
    visit new_post_path
    should_be_denied_access
  end

  scenario "happy path" do
    me = Fabricate(:user, name: "Bob")
    signin_as me
    click_on "Share Some Knowledge"
    fill_in "Title", with: "TIL: Mugs don't wash themselves"
    fill_in "Body", with: "There are some simple steps to washing a mug.  First, don't set it in the sink.  Then, apply soap, scrub and rinse.  Finally, do set the mug in the drying rack."
    click_on "Publish Knowledge"
    page.should have_notice("Your knowledge has been published")
    current_path.should == user_posts_path(me)
    page.should have_link "TIL: Mugs don't wash themselves"
    click_on "TIL: Mugs don't wash themselves"
    page.should have_css("p", text: "There are some simple steps to washing a mug.  First, don't set it in the sink.  Then, apply soap, scrub and rinse.  Finally, do set the mug in the drying rack.")
    page.should have_css(".author", text: "Bob")
  end

  scenario "sad path" do
    me = Fabricate(:user, name: "Bob")
    signin_as me
    click_on "Share Some Knowledge"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_on "Publish Knowledge"
    page.should have_alert("Your knowledge could not be published.  Please correct the errors below.")
    page.should have_error("can't be blank", on: "Title")
    page.should have_error("can't be blank", on: "Body")
  end
end

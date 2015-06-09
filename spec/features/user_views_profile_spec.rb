feature "User views profile" do
  let(:joey){ Fabricate(:user, name: "Joey") }

  scenario "viewing profile when not signed in" do
    visit root_path
    page.should_not have_link("Joey")
  end

  scenario "viewing profile when signed in" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: joey.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    within("ul") do
      page.should have_css("li:last-child a", text: "Joey")
    end
    click_on "Joey"
    current_path.should == user_path(joey)
    page.should have_content("Joey")
    page.should have_content(joey.email)
    page.should have_content(joey.bio)
    page.should have_link("Edit")
  end
end


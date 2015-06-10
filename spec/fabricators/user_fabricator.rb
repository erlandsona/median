Fabricator(:user) do
  name   { Faker::Name.name }
  email  { Faker::Internet.email }
  username { Faker::Internet.user_name(3) }
  password              "password1"
  password_confirmation "password1"
end

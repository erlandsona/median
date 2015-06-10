Fabricator(:user) do
  name   { Faker::Name.name }
  email  { Faker::Internet.email }
  username { Faker::Internet.user_name }
  password              "password1"
  password_confirmation "password1"
end

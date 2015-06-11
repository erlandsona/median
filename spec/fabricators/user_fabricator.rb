Fabricator(:user) do
  name   { Faker::Name.name }
  email  { Faker::Internet.email }
  username { Faker::Name.first_name }
  password              "password1"
  password_confirmation "password1"
end

Fabricator(:user) do
  name   { Faker::Name.name }
  bio    { Faker::Lorem.paragraph }
  email  { Faker::Internet.email }
  username { Faker::Name.first_name }
  password              "password1"
  password_confirmation "password1"
end

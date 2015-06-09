Fabricator(:user) do
  name   { Faker::Name.name }
  bio    { Faker::Lorem.paragraph }
  email  { Faker::Internet.email }
  password              "password1"
  password_confirmation "password1"
end

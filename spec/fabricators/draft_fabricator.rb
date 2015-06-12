Fabricator(:draft, from: :post) do
  author(fabricator: :user)
  title { Faker::Lorem.words(4) }
  body { Faker::Lorem.paragraph(2) }
  published_at { nil }
end
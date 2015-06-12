Fabricator(:comment) do
  author(fabricator: :user)
  post(fabricator: :post)
  body { Faker::Lorem.paragraph(2) }
end

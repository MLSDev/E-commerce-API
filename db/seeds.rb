1000.times do
  Product.create \
    name: Faker::Commerce.product_name,
    price: Faker::Number.between(1, 150),
    description: Faker::Commerce.department
end
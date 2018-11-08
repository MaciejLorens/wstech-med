maciej = User.create(first_name: 'Maciej', last_name: 'Lorens', email: 'mckl@poczta.fm', password: 'wstechmaciej', admin: true)
jacek = User.create(first_name: 'Jacek', last_name: 'Mazur', email: 'jmazur@pro.onet.pl ', password: 'wstechjacek', admin: true)
robert = User.create(first_name: 'Robert', last_name: 'Lorens', email: 'robertlo@op.pl', password: 'wstechrobert', admin: true)

purchaser_1 = Purchaser.create(name: 'Stomil')
purchaser_2 = Purchaser.create(name: 'Autosan')
purchaser_3 = Purchaser.create(name: 'Airbus')
purchaser_4 = Purchaser.create(name: 'Tesla')
purchaser_5 = Purchaser.create(name: 'Spacex')


50.times do |i|
  order = Order.create(
    user_id: [maciej, jacek, robert].sample.id,
    purchaser_id: [purchaser_1, purchaser_2, purchaser_3].sample.id,
    delivery_request_date: Time.now - rand(10).days,
    status: %w(ordered ready_to_delivery delivered deleted).sample,
  )

  (rand(5) + 1).times do
    order.items.create(
      description: "Lorem ipsum dolor sit amet #{i}-#{j}",
      quantity: rand(100),
      price: rand * 200
    )
  end
end

maciej = User.create(first_name: 'Maciej', last_name: 'Lorens', email: 'maciej.lorens@gmail.com', password: '1234567890', admin: true)
jacek = User.create(first_name: 'Jacek', last_name: 'Mazur', email: 'jmazur@pro.onet.pl', password: 'wstechjacek', admin: true)
robert = User.create(first_name: 'Robert', last_name: 'Lorens', email: 'robertlo@op.pl', password: 'wstechrobert', admin: true)


paulina = User.create(first_name: 'Paulina', last_name: '', email: 'paulina@wstech.eu', password: 'wstechpaulina', admin: true)
klaudia = User.create(first_name: 'Klaudia', last_name: '', email: 'klaudia@wstech.eu', password: 'wstechklaudia', admin: true)
ilona = User.create(first_name: 'Ilona', last_name: '', email: 'ilona@wstech.eu', password: 'wstechilona', admin: true)
bartek = User.create(first_name: 'Monter', last_name: '', email: 'monter@wstech.eu', password: 'wstechmonter', admin: false)
monter1 = User.create(first_name: 'Monter1', last_name: '', email: 'monter1@wstech.eu', password: 'wstechmonter1', admin: false)
monter2 = User.create(first_name: 'Monter2', last_name: '', email: 'monter2@wstech.eu', password: 'wstechmonter2', admin: false)
monter3 = User.create(first_name: 'Monter3', last_name: '', email: 'monter3@wstech.eu', password: 'wstechmonter3', admin: false)
monter4 = User.create(first_name: 'Monter4', last_name: '', email: 'monter4@wstech.eu', password: 'wstechmonter4', admin: false)


purchaser_1 = Purchaser.create(name: 'Stomil')
purchaser_2 = Purchaser.create(name: 'Autosan')
purchaser_3 = Purchaser.create(name: 'Airbus')
purchaser_4 = Purchaser.create(name: 'Tesla')
purchaser_5 = Purchaser.create(name: 'Spacex')

lorem = %w(Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua)

50.times do |i|
  order = Order.create(
    user_id: [paulina, klaudia, ilona, bartek].sample.id,
    purchaser_id: [purchaser_1, purchaser_2, purchaser_3].sample.id,
    delivery_request_date: Time.now - rand(10).days,
    status: %w(ordered queue assembly suspended ready_to_delivery delivered deleted).sample,
    client_order_number: SecureRandom.hex(3),
    assembly_at: rand(10).days.from_now,
    created_at: rand(150).days.ago
  )

  (rand(5) + 1).times do |j|
    order.items.create(
      product: "product-#{SecureRandom.hex(3)}",
      model: "model-#{SecureRandom.hex(3)}",
      options: "options-#{SecureRandom.hex(3)}",
      color: %w(Niebieski Czerwony Fioletowy Żółty Czarny Biały).sample,
      quantity: rand(100)
    )
  end
end

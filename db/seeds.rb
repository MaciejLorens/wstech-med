maciej = User.create(
  first_name: 'Maciej',
  last_name: 'Lorens',
  email: 'maciej.lorens@gmail.com',
  password: 'Im1bF5mF',
  admin: true)

jacek = User.create(
  first_name: 'Jacek',
  last_name: 'Mazur',
  email: 'jmazur@pro.onet.pl',
  password: 'h8c7Zpcr',
  admin: true)

robert = User.create(
  first_name: 'Robert',
  last_name: 'Lorens',
  email: 'robertlo@op.pl',
  password: 'uvhK9LlC',
  admin: true)

andrzej = User.create(
  first_name: 'Andrzej',
  last_name: '',
  email: 'andrzej@wstech.eu',
  password: 'gcN2xW99',
  admin: true)


paulina = User.create(
  first_name: 'Paulina',
  last_name: '',
  email: 'paulina@wstech.eu',
  password: 'SnJNx9jq',
  admin: true)

klaudia = User.create(
  first_name: 'Klaudia',
  last_name: '',
  email: 'klaudia@wstech.eu',
  password: '2qbEAkqD',
  admin: true)

ilona = User.create(
  first_name: 'Ilona',
  last_name: '',
  email: 'ilona@wstech.eu',
  password: 'fI9GmwE4',
  admin: true)


bartek = User.create(
  first_name: 'Bartek',
  last_name: '',
  email: 'bartek@wstech.eu',
  password: 'dtsMEmp3',
  admin: false)

wojtek = User.create(
  first_name: 'Wojtek',
  last_name: '',
  email: 'wojtek@wstech.eu',
  password: '8KAjmcai',
  admin: false)

bogdan = User.create(
  first_name: 'Bogdan',
  last_name: '',
  email: 'bogdan@wstech.eu',
  password: 'YVwDzH17',
  admin: false)

maciek = User.create(
  first_name: 'Maciek',
  last_name: '',
  email: 'maciek@wstech.eu',
  password: 'zQUVZU0y',
  admin: false)


purchaser_1 = Purchaser.create(name: 'Stomil')
purchaser_2 = Purchaser.create(name: 'Autosan')
purchaser_3 = Purchaser.create(name: 'Airbus')
purchaser_4 = Purchaser.create(name: 'Tesla')
purchaser_5 = Purchaser.create(name: 'Spacex')

lorem = %w(Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua)

User.all.each do |user|
  user.generate_code
end

50.times do |i|
  order = Order.create(
    user_id: [paulina, klaudia, ilona, bartek].sample.id,
    purchaser_id: [purchaser_1, purchaser_2, purchaser_3].sample.id,
    delivery_request_date: Time.now - rand(10).days,
    status: %w(ordered queue assembly suspended ready_to_delivery delivered deleted).sample,
    client_order_number: SecureRandom.hex(3),
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

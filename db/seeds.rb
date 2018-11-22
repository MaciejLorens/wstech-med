maciej = User.create(first_name: 'Maciej', last_name: 'Lorens', email: 'mckl@poczta.fm', password: 'wstechmaciej', admin: true)
jacek = User.create(first_name: 'Jacek', last_name: 'Mazur', email: 'jmazur@pro.onet.pl', password: 'wstechjacek', admin: true)
robert = User.create(first_name: 'Robert', last_name: 'Lorens', email: 'robertlo@op.pl', password: 'wstechrobert', admin: true)


paulina = User.create(first_name: 'Paulina', last_name: '', email: 'paulina@wstech.eu', password: 'wstechpaulina', admin: false)
klaudia = User.create(first_name: 'Klaudia', last_name: '', email: 'klaudia@wstech.eu', password: 'wstechklaudia', admin: false)
ilona = User.create(first_name: 'Ilona', last_name: '', email: 'ilona@wstech.eu', password: 'wstechilona', admin: false)
bartek = User.create(first_name: 'Bartek', last_name: '', email: 'bartek@wstech.eu', password: 'wstechbartek', admin: false)

purchaser_1 = Purchaser.create(name: 'Stomil')
purchaser_2 = Purchaser.create(name: 'Autosan')
purchaser_3 = Purchaser.create(name: 'Airbus')
purchaser_4 = Purchaser.create(name: 'Tesla')
purchaser_5 = Purchaser.create(name: 'Spacex')

lorem = %w(Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua)

150.times do |i|
  order = Order.create(
    user_id: [paulina, weronika, justyna, natalia].sample.id,
    purchaser_id: [purchaser_1, purchaser_2, purchaser_3].sample.id,
    delivery_request_date: Time.now - rand(10).days,
    status: %w(ordered ready_to_delivery delivered deleted).sample,
    created_at: rand(150).days.ago
  )

  (rand(5) + 1).times do |j|
    order.items.create(
      description: "start-#{Array.new(rand(30)).map{lorem.sample}.join(' ')}-end",
      quantity: rand(100),
      price: rand * 200
    )
  end
end

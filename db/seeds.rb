maciej = User.create(first_name: 'Maciej', last_name: 'Lorens', email: 'mckl@poczta.fm', password: 'wstechmaciej', admin: true)
jacek = User.create(first_name: 'Jacek', last_name: 'Mazur', email: 'jmazur@pro.onet.pl ', password: 'wstechjacek', admin: true)

client = User.create(first_name: 'Tomasz', last_name: 'Somer', email: 'tomasz@somer.pl', password: 'wstechtclient', admin: false)


50.times do |idnex|
  Order.create(
    user_id: client.id,
    description: "Lorem ipsum dolor sit amet #{idnex}",
    quantity: rand(100),
    price: rand * 200,
    delivery_request_date: Time.now - rand(10).days,
    confirmation_date: Time.now - rand(10).days,
    status: %w(ordered ready_to_delivery delivered deleted).sample
  )
end

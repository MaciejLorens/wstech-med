client = User.create(email: 'franek@golas.fm', password: 'password', admin: false)
admin = User.create(email: 'mckl@poczta.fm', password: 'password', admin: true)

client.metal_orders.create(description: 'dwie ramy', quantity: 17, price: 234.77, delivery_request_date: Time.now + 3.days, confirmation_date: Time.now + 4.days)
client.metal_orders.create(description: 'stelaż', quantity: 9, price: 123.74, delivery_request_date: Time.now + 1.days, confirmation_date: Time.now + 1.days)
client.furniture_orders.create(description: 'stol', quantity: 4, price: 1393.20, delivery_request_date: Time.now + 7.days, confirmation_date: Time.now + 9.days)
client.furniture_orders.create(description: 'regal', quantity: 11, price: 13546.32, delivery_request_date: Time.now + 12.days, confirmation_date: Time.now + 12.days)
client.furniture_orders.create(description: 'biurko', quantity: 1, price: 199.11, delivery_request_date: Time.now + 5.days, confirmation_date: Time.now + 7.days)

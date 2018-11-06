maciej = User.create(first_name: 'Maciej', last_name: 'Lorens', email: 'mckl@poczta.fm', password: 'wstechmaciej', admin: true)
jacek = User.create(first_name: 'Jacek', last_name: 'Mazur', email: 'jmazur@pro.onet.pl ', password: 'wstechjacek', admin: true)

client = User.create(first_name: 'Tomasz', last_name: 'Somer', email: 'tomasz@somer.pl', password: 'wstechtomasz', admin: false)


Order.create(type: 'MetalOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat', quantity: 17, price: 234.77, delivery_request_date: Time.now + 3.days, confirmation_date: Time.now + 4.days)
Order.create(type: 'MetalOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', quantity: 9, price: 123.74, delivery_request_date: Time.now + 1.days, confirmation_date: Time.now + 1.days)
Order.create(type: 'MetalOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', quantity: 17, price: 234.77, delivery_request_date: Time.now + 3.days, confirmation_date: Time.now + 4.days)
Order.create(type: 'MetalOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat', quantity: 9, price: 123.74, delivery_request_date: Time.now + 1.days, confirmation_date: Time.now + 1.days)
Order.create(type: 'FurnitureOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', quantity: 4, price: 1393.20, delivery_request_date: Time.now + 7.days, confirmation_date: Time.now + 9.days)
Order.create(type: 'FurnitureOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat', quantity: 11, price: 13546.32, delivery_request_date: Time.now + 12.days, confirmation_date: Time.now + 12.days)
Order.create(type: 'FurnitureOrder', user_id: client.id, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam', quantity: 1, price: 199.11, delivery_request_date: Time.now + 5.days, confirmation_date: Time.now + 7.days)


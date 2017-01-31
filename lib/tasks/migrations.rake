namespace :migrations do

  desc 'migrate from has_many to habtm for orders and wzs'
  task :has_many_to_habtm, [] => :environment do |t, args|
    p '------------- START -------------'

    Order.all.each_with_index do |order, index|
      p index if (index % 100).zero?
      wz = Wz.where(id: order.wz_id).first
      if wz.present?
        order.orders_wzs.create(wz_id: wz.id, quantity: order.quantity)
        order.update(quantity_in_wz: order.quantity, full_in_wz: true)
      end
    end
    p '-------------- END --------------'
  end
end

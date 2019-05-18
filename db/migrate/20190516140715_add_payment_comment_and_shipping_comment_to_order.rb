class AddPaymentCommentAndShippingCommentToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_comment, :string
    add_column :orders, :shipping_comment, :string
  end
end

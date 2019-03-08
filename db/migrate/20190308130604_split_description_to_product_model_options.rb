class SplitDescriptionToProductModelOptions < ActiveRecord::Migration
  def up
    add_column :items, :product, :string
    add_column :items, :model, :string
    add_column :items, :options, :string

    Item.all.each do |item|
      item.update(product: item.description)
    end

    remove_column :items, :description
  end

  def down
    add_column :items, :description, :string

    Item.all.each do |item|
      description = item.product
      description += " #{item.model}" if item.model.present?
      description += " #{item.options}" if item.options.present?

      item.update(description: description)
    end

    remove_column :items, :product
    remove_column :items, :model
    remove_column :items, :options
  end
end

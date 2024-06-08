class AddUrlToProductTable < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :url, :string
    add_column :products, :image_url, :string
  end
end

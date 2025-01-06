class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :image, limit: 500
      t.string :subtitle, limit: 500
      t.references :author, foreign_key: true
      t.references :genre, foreign_key: true
      t.integer :publishing_year
      t.integer :quantity_in_stock, null: false
      t.string :description, limit: 1000
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :delete_flag, null: false, default: false
      # t.timestamps
    end
  end
end

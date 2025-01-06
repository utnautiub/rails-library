class CreateBorrowingItems < ActiveRecord::Migration[8.0]
  def change
    create_table :borrowing_items do |t|
      t.references :borrowing, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :delete_flag, null: false, default: false
      # t.timestamps
    end
  end
end

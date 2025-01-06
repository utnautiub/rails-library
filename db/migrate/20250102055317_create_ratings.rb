class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.references :book, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :star, null: false
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :delete_flag, null: false, default: false
      # t.timestamps
    end
  end
end

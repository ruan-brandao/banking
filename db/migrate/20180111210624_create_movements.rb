class CreateMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :movements do |t|
      t.integer :amount
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end

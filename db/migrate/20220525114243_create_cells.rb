class CreateCells < ActiveRecord::Migration[7.0]
  def change
    create_table :cells do |t|
      t.belongs_to :line, null: false, foreign_key: true
      t.boolean :bomb, default: false
      t.integer :close_bombs, default: 0
      t.boolean :flag, default: false
      t.boolean :discovered, default: false

      t.timestamps
    end
  end
end

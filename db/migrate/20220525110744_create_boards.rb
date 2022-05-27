class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.integer :height
      t.integer :width
      t.integer :bombs_count
      t.boolean :playing, default: true

      t.timestamps
    end
  end
end

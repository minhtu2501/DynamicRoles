class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.string :sheet_number
      t.integer :part_id

      t.timestamps null: false
    end
  end
end

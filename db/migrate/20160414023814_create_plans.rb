class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :number
      t.integer :part_id

      t.timestamps null: false
    end
  end
end

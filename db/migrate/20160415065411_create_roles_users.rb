class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users, id: false  do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :role, index: true, foreign_key: true
    end
  end
end

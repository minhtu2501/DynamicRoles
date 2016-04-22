class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles, id: false do |t|
	  t.belongs_to :role, index: true, foreign_key: true
    t.belongs_to :permission, index: true, foreign_key: true
    end
  end
end

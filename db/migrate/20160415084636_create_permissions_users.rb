class CreatePermissionsUsers < ActiveRecord::Migration
  def change
    create_table :permissions_users, id: false do |t|
    	t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :permission, index: true, foreign_key: true
    end
  end
end

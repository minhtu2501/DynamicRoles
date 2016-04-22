class Role < ActiveRecord::Base
   has_many :roles_users, foreign_key: :role_id
   has_many :permissions_roles, foreign_key: :role_id
   has_many :permissions, through: :permissions_roles, dependent: :destroy
   has_many :users, through: :roles_users, dependent: :destroy

   validates :name, presence: true, uniqueness: true

  def set_permissions(permissions)
    permissions.each do |id|
      permission = Permission.find(id)
      self.permissions << permission
      # case permission.subject_class
      # when "Part"
      #   case permission.action
      #   when "create"
      #     self.permissions << Permission.where(subject_class: "Drawing", action: "create")
      #   when "update"
      #     self.permissions << Permission.where(subject_class: "Drawing", action: ["update", "destroy"])
      #   end
      # end
    end
  end
end

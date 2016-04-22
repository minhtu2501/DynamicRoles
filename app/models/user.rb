class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :roles_users, foreign_key: :user_id
  has_many :roles, through: :roles_users, dependent: :destroy
  has_many :permissions_users, foreign_key: :user_id
  has_many :permissions, through: :permissions_users, dependent: :destroy
  has_many :role_permissions, through: :roles, source: :permissions

  def super_admin?
    self.roles.each do |role|
  	  role.name == "Super Admin"
  	end
  end
  
  def set_roles(roles)
    roles.each do |id|
      role = Role.find(id)
      self.roles << role
    end
  end

  def set_permissions(permissions)
    permissions.each do |id|
      unless self.role_permissions.collect{|p| p.id}.include?(id.to_i)
        permission = Permission.find(id)
        self.permissions << permission
      end
    end
  end



  # def set_role_permissions
  #   role_permissions.each do |id|
  #     permission = Permission.find(id)
  #     self.role_permissions << permission
  #   end
  # end
end

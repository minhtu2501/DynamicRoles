class PermissionsRole < ActiveRecord::Base
  belongs_to :permission, foreign_key: :permission_id
  belongs_to :role, foreign_key: :role_id
end

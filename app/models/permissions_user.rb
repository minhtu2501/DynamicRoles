class PermissionsUser < ActiveRecord::Base
  belongs_to :permission, foreign_key: :permission_id
  belongs_to :user, foreign_key: :user_id
end

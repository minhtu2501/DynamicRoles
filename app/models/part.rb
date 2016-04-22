class Part < ActiveRecord::Base
	has_many :drawings, dependent: :destroy
end

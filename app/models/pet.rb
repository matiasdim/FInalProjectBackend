class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :reports
end

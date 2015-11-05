class Wici < ActiveRecord::Base
  belongs_to :user
  scope :visible_to, -> (user, viewable = false) {user.standard? ? where(:private => false) : all }
end

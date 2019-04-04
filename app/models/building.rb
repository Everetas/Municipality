class Building < ActiveRecord::Base

  has_one :street
  has_one :administrator

end

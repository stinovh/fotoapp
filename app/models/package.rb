class Package < ActiveRecord::Base
  scope :available, -> { in_time.where(sold: false) }
  scope :in_time, -> { where("start_time < '#{Time.now}'").where("end_time > '#{Time.now}'") }
end

class Package < ActiveRecord::Base
  scope :available, -> { in_time.where(sold: false) }
  scope :in_time, -> { where("start_time < '#{Time.now}'").where("end_time > '#{Time.now}'") }

  def current_price
    if reserved
      "reserved"
    else
      (self.start_price_cents/100) - (((self.start_price_cents/100 - self.minimum_price_cents/100) / (self.end_time - self.start_time)) * (Time.now - self.start_time))
    end
  end
end

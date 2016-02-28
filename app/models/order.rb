class Order < ActiveRecord::Base
  belongs_to :package

  validates :full_name, :email, presence: true

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "seller-stijn@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: package.current_price.round(2),
        item_name: package.name,
        item_number: package.id,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end

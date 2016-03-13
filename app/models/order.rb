class Order < ActiveRecord::Base
  belongs_to :package

  validates :full_name, :email, :payment_method, presence: true

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "seller-stijn@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: created_at.to_i,
        amount: (package.price_now_cents/100),
        currency_code: "EUR",
        item_name: package.name,
        item_number: package.id,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook",
        on0: "order_id",
        os0: id
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end

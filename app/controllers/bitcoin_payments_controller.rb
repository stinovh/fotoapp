class BitcoinPaymentsController < ApplicationController
  def index
    @order = Order.find(params[:order_id])
    @package = @order.package
    @bitcoin_price = Blockchain.to_btc('EUR', @package.price_now_cents.to_f/100)
    callback_url = "#{Rails.application.secrets.app_host}/confirmation?secret=#{Rails.application.secrets.secret}&order=#{@order.id}"
    if @order.address.blank?
      @resp = Blockchain::V2::receive(Rails.application.secrets.xpub, callback_url, Rails.application.secrets.blockchain_api)
      @order.update(address: @resp.address)
    end
  end

  def update_order_status
    @order ||= Order.find(params[:id])
  end
end

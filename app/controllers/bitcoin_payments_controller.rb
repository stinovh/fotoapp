class BitcoinPaymentsController < ApplicationController
  def index
    @order = Order.find(params[:order_id])
    @package = @order.package
    callback_url = "#{Rails.application.secrets.app_host}/confirmation?secret=#{Rails.application.secrets.secret}&order=#{@order.id}"
    @resp = Blockchain::V2.receive(Rails.application.secrets.xpub, callback_url, Rails.application.secrets.blockchain_api)
    @order.update(address: @resp.address) if @order.address.blank?
  end
end

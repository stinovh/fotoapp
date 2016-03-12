class BitcoinPaymentsController < ApplicationController
  def index
    @order = Order.find(params[:order_id])
    @package = @order.package
  end
end

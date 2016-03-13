class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  after_action :add_more_time, only: [:create]

 # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @package = Package.find(params[:package_id])
    @package.update(price_now_cents: (@package.current_price*100), reserved_till: Time.now + 120) if !@package.reserved
    @package.update(reserved: true)
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @package = Package.find(params[:package_id])
    if @order.save && params[:order][:payment_method] == "PayPal"
      redirect_to @order.paypal_url(root_path)
    elsif @order.save && params[:order][:payment_method] == "Bitcoin"
      redirect_to package_order_bitcoin_payments_path(@package, @order)
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @order = Order.find params[:option_selection1]
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
      @package = Package.find(@order.package_id)
      @package.update(sold: true)
    end
    render nothing: true
  end

  private

    def add_more_time
      package = Package.available.first
      package.update(reserved_till: package.reserved_till + 120)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:package_id, :full_name, :email, :payment_method)
    end
end

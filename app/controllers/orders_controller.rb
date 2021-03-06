class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  after_action :add_more_time, only: [:create]
  before_action :set_package, only: [:new, :create]

 # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @package.update(price_now_cents: (@package.current_price*100), reserved_till: Time.now + 300) if !@package.reserved
    @package.update(reserved: true)
  end

  def show_reserved_time
    @package = Package.available.first
    if @package.reserved_till.nil?
      redirect_to :back
    end
    respond_to do |format|
      format.js
    end
  end

  # POST /orders
  def create
    if Time.now > @package.reserved_till
      redirect_to root_path, :flash => { :error => "Sorry, your order expired!" }
    else
      @order = Order.new(order_params)
      if @order.save && params[:order][:payment_method] == "PayPal"
        redirect_to @order.paypal_url(root_path)
      elsif @order.save && params[:order][:payment_method] == "Bitcoin"
        redirect_to package_order_bitcoin_payments_path(@package, @order)
      else
        render :new
      end
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @order = Order.find(params[:option_selection1])
      @package = Package.find(@order.package_id)
      @package.update(sold: true)
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  def awaiting_confirmation
    @order = Order.find(params[:id])
  end

  def confirmation
    params.permit!
    order = Order.find(params[:order])
    address = params[:address]
    secret = params[:secret]
    confirmations = params[:confirmations].to_i
    tx_hash = params[:transaction_hash]
    value = params[:value].to_f / 100000000

    return 400, 'Incorrect Receiving Address' unless order.address == address
    return 400, 'Invalid Secret' unless secret == Rails.application.secrets.secret
    # if value == Blockchain.to_btc('EUR', order.package.price_now_cents/100)
    if confirmations >= 4
      order.update(status: "Completed", bitcoin_params: tx_hash)
      order.package.update(sold: true)
      return 200, '*ok*'
    else
      order.update(status: "Awaiting Confirmation", bitcoin_params: tx_hash)
      order.update(confirmations: confirmations)
      return 200, 'Waiting for confirmations'
    end
    # shouldn't ever reach this
    return 500, 'something went wrong'
  end

  private

    def set_package
      @package = Package.find(params[:package_id])
    end

    def add_more_time
      package = Package.available.first
      package.update(reserved_till: package.reserved_till + 10800)
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

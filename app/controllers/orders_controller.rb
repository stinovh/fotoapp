class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

 # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @package = Package.find_by id: params[:package_id]
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order.paypal_url(packages_path)
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @order = Order.find params[:invoice]
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:package_id, :full_name, :email)
    end
end

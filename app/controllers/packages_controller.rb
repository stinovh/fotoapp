class PackagesController < ApplicationController
  after_action :check_reserved, only: [:update_price]
  protect_from_forgery except: [:index]
  def index
    @package = Package.available.first
  end

  def update_price
    @package = Package.available.first
    respond_to do |format|
      format.js
    end
  end

  private

  def check_reserved
    @package = Package.available.first
    if !@package.reserved_till.nil? && @package.reserved_till < Time.now && @package.sold == false
      @package.update(reserved: false, reserved_till: nil)
    end
  end
end

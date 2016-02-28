class PackagesController < ApplicationController
  protect_from_forgery except: [:index]
  def index
    @package = Package.available.first
  end
end

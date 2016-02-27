class PackagesController < ApplicationController
  def index
    @package = Package.available.first
  end
end

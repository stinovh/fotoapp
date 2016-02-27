class PackageController < ApplicationController
  def index
    @packages = Package.available
  end
end

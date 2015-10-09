class Api::ProductsController < ApplicationController
  private
  def collection
    @products ||= Product.all
  end

  def resource
    @product ||= Product.find params[:id]
  end
end
class Api::ProductsController < ApplicationController
  private
  def collection
    @products ||= Product.search_by(params)
  end

  def resource
    @product ||= Product.find params[:id]
  end
end
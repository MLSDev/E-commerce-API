class Api::SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  private
  def build_resource
    @session = Session.new resource_params
  end

  def resource
    @session ||= Session.new user: current_user
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end
end
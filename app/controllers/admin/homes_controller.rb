class Admin::HomesController < ApplicationController
  before_action :authenticate_user!

  def top
    @orders = Order.all
  end
end
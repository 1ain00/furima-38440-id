class BuysController < ApplicationController
  before_action :item_find, only: [:index, :create]
  before_action :authenticate_user!, only: :index
  before_action :redirect_to_root_path, only: :index

  def index
    @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
      @buy_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_address).permit(:post_code, :prefecture_id, :city, :address, :building, :telephone).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def redirect_to_root_path
    if @item.user_id == current_user.id || @item.buy.present?
      redirect_to root_path
    end
  end


end

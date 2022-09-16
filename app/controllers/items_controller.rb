class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  #before_action :login, only: [:update, :edit, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
       @item.save
       redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, :price, :image ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def login
    @item = Item.find(params[:id])
    if current_user.id != @item.user_id
       redirect_to root_path
    end
  end
end


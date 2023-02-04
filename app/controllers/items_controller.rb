class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
   end
   render json: items, include: :user
  end

  def show 
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.create(name: params[:name], description: params[:description], price: params[:price], user_id: params[:user_id])
    render json: item, status: :created
  end

  private 

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end

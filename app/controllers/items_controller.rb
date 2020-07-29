class ItemsController < ApplicationController
  
  def index
  end

  def show
  end

  def new
  end

  def index2
    @categories = Category.all
    @items = Item.all
  end

end

class ItemsController < ApplicationController
  
  def index
  end

  def show
  end

  def new
  end

  def index2
    @parents = Category.where(ancestry: nil)
  end
  
end

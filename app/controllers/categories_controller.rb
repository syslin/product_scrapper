class CategoriesController < ApplicationController
  def index
    categories = Category.includes(:products) # Include associated products in the query
    render json: categories, include: :products
  end
end

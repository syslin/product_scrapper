class ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: @products
  end

  def create
    url = params[:url]
    ScraperService.new(url).scrape
    render json: { message: 'Product scraped successfully' }
  end

  def update
    product = Product.find(params[:id])
    ScraperService.new(product.url).scrape
    render json: { message: 'Product updated successfully' }
  end

  def search
    @products = Product.where("LOWER(title) LIKE ?", "%#{params[:query].downcase}%")
    render json: @products
  end

end
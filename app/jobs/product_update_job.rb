# app/jobs/product_updater_job.rb
class ProductUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Product.where('updated_at < ?', 1.week.ago).each do |product|
      ScraperService.new(product.url).scrape
    end
  end
end
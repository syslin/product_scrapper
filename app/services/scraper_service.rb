require 'open-uri'
require 'nokogiri'

class ScraperService
  USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'

  def initialize(url)
    @url = url
  end

  def scrape
    retry_count = 0
    begin
      doc = Nokogiri::HTML(URI.open(@url, 'User-Agent' => USER_AGENT))
      # Extract product details
      title = doc.css('title').text.strip
      description = doc.css('meta[name="og:description"]').first['content']
      parsed_data = JSON.parse(doc.css('script').text.match(/pdpTrackingData\s*=\s*"(.*?)";/m)[1].gsub('\\"', '"').gsub('\\\\', '\\'))
      price = parsed_data['pdt_price'].gsub(/\D/, '').to_i
      contact_info =  parsed_data['seller_name']
      category_name = parsed_data['pdt_category'][0]
      img_url = parsed_data['pdt_photo']

      category = Category.find_or_create_by(name: category_name)

      Product.create!(
        title: title,
        description: description,
        price: price,
        category: category,
        url: @url,
        image_url: img_url
      )
    rescue OpenURI::HTTPError => e
      if retry_count < MAX_RETRIES
        retry_count += 1
        sleep 2 ** retry_count # Exponential backoff
        retry
      else
        raise "Failed to scrape the URL after #{MAX_RETRIES} attempts: #{e.message}"
      end
    end
  end
end

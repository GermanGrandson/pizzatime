require 'mechanize'

class Scrape

  # Mechanize will search for pizza shop with shop name and page url and get specific
  # restaurant link and scrape its data. Data gets pushed into array of hashes.
  def scrape_shop(pizza_shop, limit)
    mechanize = Mechanize.new
    # sleep(2) #Used to avoid timeout issues with Mechanize
    begin
      page = mechanize.get("https://www.yelp.com/search?find_desc=#{pizza_shop}+pizza&find_loc=New+York,+NY")

      if page.root.css('.search-header-title-container > h1').text.strip.include? "No Results"
        false
      else
        link = page.root.css('.regular-search-result > .search-result > .biz-listing-large > .main-attributes > .media-block > .media-story > .search-result-title > .indexed-biz-name > a').first
        link = link.attributes['href'].value

        review_page = mechanize.get("http://yelp.com#{link}?sort_by=date_desc")
        yelp_reviews = review_page.root.css('.review')
        reviews_array = []

        yelp_reviews[1..limit].each do |yelp_review|
          rating = yelp_review.css('.review-wrapper > .review-content > .biz-rating > div > .i-stars').attribute('title').value
          date = yelp_review.css('.review-wrapper > .review-content > .biz-rating > .rating-qualifier').children.text.strip
          text = yelp_review.css('.review-wrapper > .review-content > p').text.strip
          pic = yelp_review.css('.review-sidebar > .review-sidebar-content > .ypassport > .media-avatar > .photo-box > a > img').attribute('src').value
          username = yelp_review.css('.review-sidebar > .review-sidebar-content > .ypassport > .media-story > .user-passport-info > .user-name > a').text.strip

          review = Review.new(rating, date, text, pic, username)
          reviews_array << review
        end

        name = review_page.root.css('.biz-page-title').text.strip
        address = review_page.root.css('.street-address').text.strip
        phone = review_page.root.css('.biz-phone').text.strip
        time = review_page.root.css('.u-space-r-half').text.strip

        shop = Shop.new(name, address, phone, time)
        return shop, reviews_array
      end

    rescue Net::HTTPInternalError
      puts 'An error occurred'
    rescue ResponseCodeError
      puts "ResponseCodeError occurred"
    end

  end

end

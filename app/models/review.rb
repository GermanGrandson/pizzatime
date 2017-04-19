class Review

  attr_accessor :rating, :date, :text, :pic, :username

  def initialize(rating, date, text, pic, username)
    @rating = rating
    @date = date
    @text = text
    @pic = pic
    @username = username
  end

end

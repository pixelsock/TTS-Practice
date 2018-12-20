class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags
  validates :message, presence: true
  validates :message, length: {maximum: 140, too_long: "A tweet is only 140 max. Everybody knows that!"}

  before_validation :link_check

  validates :message, length: { maximum: 140 }

  private

  def link_check
      # contents hidden for this slide
  end
end



#we're looking to see if there's a URL in a new or editied message.
  def link_check
  check = false
  if self.message.include? "http://"
     check = true
  elsif self.message.include? "https://"
     check = true
  else
       check = false
  end

  if check == true
  arr = self.message.split
  index = arr.map{ |x| x.include? "http"}.index(true)
    self.link = arr[index]
    if arr[index].length > 23
      arr[index] = "#{arr[index][0..20]}..."
    end

    self.message = arr.join(" ")
  end
 end
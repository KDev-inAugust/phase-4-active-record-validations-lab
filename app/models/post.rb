require "pry"
class Post < ApplicationRecord
    
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {in: 0..250}
    validates :category, inclusion:  {in: %w(Fiction Non-Fiction)}

    # validate :click_bait

    # # custom validation----
    
    # def click_bait
    #     # binding.pry
    #     unless title.match?("Won't Believe") || title.match?("Secret") || title.match?("Guess")
    #         errors.add(:title, "title not dumb enough")
    #     end
    # end

    validate :clickbait?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def clickbait?
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end
    
end



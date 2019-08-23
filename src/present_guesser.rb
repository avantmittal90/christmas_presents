require_relative 'wishlist'
require_relative 'present'

class PresentGuesser
  attr_accessor :wishlist, :presents

  def initialize(wishlist, presents)
    @wishlist = wishlist
    @presents = presents
  end

  def guess_gifts
    presents.map do |present|
      get_names_from_wishlist(present).compact
    end.flatten.uniq
  end

  def get_names_from_wishlist(present)
    return [] unless present

    wishlist.select do |wishlist_item|
      present.keys.map do |key|
        wishlist_item[key] == present[key]
      end.all?
    end.map { |wishlist_item| wishlist_item[:name] }
  end
end

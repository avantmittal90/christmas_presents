require_relative '../src/wishlist'
require_relative '../src/present'
require_relative '../src/present_guesser'
require 'minitest/autorun'

class TestPresentGuess < Minitest::Test
  def setup
  end

  def test_valid_present_guesses
    @wishlist = [
      {:name => "mini puzzle", :size => "small", :clatters => "yes", :weight => "light"},
      {:name => "toy car", :size => "medium", :clatters => "a bit", :weight => "medium"},
      {:name => "card game", :size => "small", :clatters => "no", :weight => "light"}
    ]

    @presents = [
      {:size => "medium", :clatters => "a bit", :weight => "medium"},
      {:size => "small", :clatters => "yes", :weight => "light"}
    ]

    import(@wishlist, @presents)
    assert_equal ["toy car", "mini puzzle"], PresentGuesser.new(Wishlist.objects, Present.objects).guess_gifts
    clear
  end

  def test_no_present_guesses
    @wishlist = [
      {:name => "mini puzzle", :size => "small", :clatters => "no", :weight => "light"},
      {:name => "toy car", :size => "medium", :clatters => "yes", :weight => "medium"},
      {:name => "card game", :size => "small", :clatters => "no", :weight => "light"}
    ]

    @presents = [
      {:size => "medium", :clatters => "a bit", :weight => "medium"},
      {:size => "small", :clatters => "yes", :weight => "light"}
    ]

    import(@wishlist, @presents)
    assert_equal [], PresentGuesser.new(Wishlist.objects, Present.objects).guess_gifts
    clear
  end

  def test_ensure_no_duplicated_names
    @wishlist = [
      {:name => "mini puzzle", :size => "small", :clatters => "yes", :weight => "light"},
      {:name => "toy car", :size => "medium", :clatters => "a bit", :weight => "medium"},
      {:name => "card game", :size => "small", :clatters => "no", :weight => "light"}
    ]

    @presents = [
      {:size => "medium", :clatters => "a bit", :weight => "medium"},
      {:size => "medium", :clatters => "a bit", :weight => "medium"},
      {:size => "small", :clatters => "yes", :weight => "light"}
    ]

    import(@wishlist, @presents)
    assert_equal ["toy car", "mini puzzle"], PresentGuesser.new(Wishlist.objects, Present.objects).guess_gifts
    clear
  end

  def test_ensure_multiple_matches_returned
    @wishlist = [
      {:name => "mini puzzle", :size => "small", :clatters => "yes", :weight => "light"},
      {:name => "magic puzzle", :size => "small", :clatters => "yes", :weight => "light"},
      {:name => "toy car", :size => "medium", :clatters => "a bit", :weight => "medium"},
      {:name => "card game", :size => "small", :clatters => "no", :weight => "light"}
    ]

    @presents = [
      {:size => "medium", :clatters => "a bit", :weight => "medium"},
      {:size => "small", :clatters => "yes", :weight => "light"}
    ]

    import(@wishlist, @presents)
    assert_equal ["toy car", "mini puzzle", "magic puzzle"], PresentGuesser.new(Wishlist.objects, Present.objects).guess_gifts
    clear
  end

  private
    def import(wishlist_objects, present_objects)
      Wishlist.import(wishlist_objects)
      Present.import(present_objects)
    end

    def clear
      Present.clear
      Wishlist.clear
    end
end

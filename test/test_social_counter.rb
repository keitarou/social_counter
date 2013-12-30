require './helper'

class TestSocialCounter < Test::Unit::TestCase
  def setup
    @url1 = "http://google.com"
    @social_counter = SocialCounter.new(@url1)
  end

  def test_url
    assert_equal(@social_counter.url, @url1)
  end

  def test_title
    p "title: #{@social_counter.title}"
  end

  def test_twitter_count
    p "twitter count: " << @social_counter.twitter_count.to_s
    p "twitter count: " << @social_counter.t.to_s
  end

  def test_facebook_count
    p "facebook count: " << @social_counter.facebook_count.to_s
    p "facebook count: " << @social_counter.f.to_s
  end

  def test_hatena_count
    p "hatena count: " << @social_counter.hatena_count.to_s
    p "hatena count: " << @social_counter.h.to_s
  end

  def test_google_count
    p "google count: " << @social_counter.google_count.to_s
    p "google count: " << @social_counter.g.to_s
  end

  def test_pocket_count
    p "pocket count: " << @social_counter.pocket_count.to_s
    p "pocket count: " << @social_counter.po.to_s
  end

  def test_linkedin_count
    p "linkedin count: " << @social_counter.linkedin_count.to_s
    p "linkedin count: " << @social_counter.l.to_s
  end

  def test_delicious_count
    p "delicious count: " << @social_counter.delicious_count.to_s
    p "delicious count: " << @social_counter.d.to_s
  end

  def test_pinterest_count
    p "pinterest count: " << @social_counter.pinterest_count.to_s
    p "pinterest count: " << @social_counter.pi.to_s
  end

  def test_all
    p @social_counter.all
  end
end

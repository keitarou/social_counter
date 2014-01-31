class SocialCounter
  require 'open-uri'
  require 'uri'
  require 'json'
  require 'nokogiri'

  attr_accessor :url

  def initialize url
    @url = url
  end

  def title
    html = Nokogiri::HTML open(@url)
    html.search('title').text
  end

  def twitter_count
    request_url = "http://urls.api.twitter.com/1/urls/count.json?url=#{@url}"
    JSON.parser.new(open(request_url).read).parse["count"].to_i
  end

  def facebook_count
    request_url = "https://graph.facebook.com/?id=#{@url}"
    JSON.parser.new(open(request_url).read).parse["shares"].to_i
  end

  def hatena_count
    request_url = "http://api.b.st-hatena.com/entry.count?url=#{@url}"
    open(request_url).read.to_i
  end

  def google_count
    key = 'AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ'
    api = URI.parse("https://clients6.google.com/rpc?key=#{key}")

    request = Net::HTTP::Post.new(api.request_uri, {
        'Content-Type' =>'application/json'
    })
    request.body = [{
        :jsonrpc    => "2.0",
        :method     => "pos.plusones.get",
        :apiVersion => "v1",
        :key        => "p",
        :id         => "p",
        :params => {
            :id         => @url,
            :userId     => "@viewer",
            :groupId    => "@self",
            :nolog      => true,
        },
    }].to_json

    response = Net::HTTP.start(api.host, api.port, :use_ssl => true) { |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.request(request)
    }

    json = JSON.parse(response.body)
    return json[0]['result']['metadata']['globalCounts']['count'].round
  end

  def pocket_count
    request_url = "https://widgets.getpocket.com/v1/button?label=pocket&count=vertical&align=left&v=1&url=#{@url}&title=&src=#{@url}&r=#{rand(100000000).to_s}"
    html = Nokogiri::HTML open(URI.escape request_url)
    html.search('#cnt').text.to_i
  end

  def linkedin_count
    request_url = "http://www.linkedin.com/countserv/count/share?url=#{@url}&format=json"
    JSON.parser.new(open(request_url).read).parse["count"].to_i
  end

  def delicious_count
    request_url = "http://feeds.delicious.com/v2/json/urlinfo/data?url=#{@url}"
    json = JSON.parser.new(open(request_url).read).parse
    json.count == 1? json[0]["total_posts"].to_i: 0
  end

  def pinterest_count
    request_url = "http://api.pinterest.com/v1/urls/count.json?url=#{@url}"
    code = open(request_url).read
    code.match(/"count":\s(\d+)/)
    $1.to_i || 0
  end

  def reddit_count
    request_url = "http://tools.mercenie.com/social-share-count/api/?flag=32&format=json&url=#{@url}"
    json = JSON.parser.new(open(request_url).read).parse
    json["reddit"]
  end

  def all
    data = {}
    self.methods.grep(/(.+)_count/) do
      data[$1] = send("#{$1}_count")
    end
    data
  end

  alias :t  :twitter_count
  alias :f  :facebook_count
  alias :h  :hatena_count
  alias :g  :google_count
  alias :po :pocket_count
  alias :l  :linkedin_count
  alias :d  :delicious_count
  alias :pi :pinterest_count
  alias :r  :reddit_count

end

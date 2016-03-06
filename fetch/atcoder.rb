module AtCoder
  def self.platform
    Platform.find_or_create(name: 'AtCoder', url: 'http://atcoder.jp/')
  end

  def self.fetch_regular_contests(prefix)
    1.upto(999).each do |num|
      url = "http://#{prefix}%03d.contest.atcoder.jp/assignments" % num
      http = Net::HTTP.get(URI.parse(url))


      p http
      sleep(2)
      break
    end
  end

  def self.parse_contest(http)

  end
end

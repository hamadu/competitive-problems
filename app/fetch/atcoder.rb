require 'nokogiri'

module AtCoder
  def self.platform
    Platform.find_or_create(name: 'AtCoder', url: 'http://atcoder.jp/')
  end

  def self.process_contest(raw_id)
    res = fetch_contest(raw_id)
    return false unless res
    raw_contest = parse_contest(res)

    p raw_contest
    return true

    contest = Contest.find_or_create(
      platform_id: platform.id,
      raw_id: raw_id,
      name: raw_contest[:name],
      url: "http://#{raw_id}.contest.atcoder.jp/",
      started_at: raw_contest[:started_at]
    )

    raw_contest[:problems].each do |problem|
      Problem.find_or_create(
        contest_id: contest.id,
        level: problem[:level],
        name: problem[:name],
        url: "http://#{raw_id}.contest.atcoder.jp#{problem[:path]}"
      )
    end
    true
  end


  def self.fetch_contest(raw_id)
    domain = "#{raw_id}.contest.atcoder.jp"
    res = Net::HTTP.get_response(URI.parse("http://#{domain}/assignments"))
    return false unless res.is_a? Net::HTTPSuccess
    res
  end

  def self.parse_contest(response)
    html = Nokogiri::HTML(response.body)

    {
      name: html.css('h1').inner_text.strip,
      started_at: Time.parse(html.css('time#contest-start-time').inner_text.strip),
      problems: html.css('table tbody tr').map do |node|
        order_in_contest = node.css('td')[0].css('a')
        link_to_problem = node.css('td')[1].css('a')
        {
          level: order_in_contest.inner_text.strip,
          name: link_to_problem.inner_text.strip,
          path: link_to_problem.attribute('href').value
        }
      end
    }
  end

  def self.fetch_regular_contests
    1.upto(10).each do |num|
      raw_id = format('arc%03d', num)
      break unless process_contest(raw_id)
      sleep(2)
    end
  end
end

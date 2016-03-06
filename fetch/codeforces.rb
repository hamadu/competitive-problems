# Codeforces
module Codeforces
  def self.platform
    Platform.find_or_create(name: 'Codeforces', url: 'http://codeforces.com/')
  end

  def self.contests_uri
    URI.parse('http://codeforces.com/api/contest.list')
  end

  def self.problems_uri
    URI.parse('http://codeforces.com/api/problemset.problems')
  end

  def self.process_contests
    Problems.new
  end

  def self.fetch_contests
    json = JSON.parse(Net::HTTP.get(contests_uri))
    json['result'].each do |raw|
      Contest.find_or_create(
        platform_id: platform.id,
        raw_id: raw['id'],
        name: raw['name'],
        url: "http://codeforces.com/contest/#{raw['id']}",
        started_at: Time.at(raw['startTimeSeconds'].to_i).utc
      )
    end
  end

  def self.fetch_problems
    json = JSON.parse(Net::HTTP.get(problems_uri))
    json['result']['problems'].each do |raw|
      contest = Contest.first(raw_id: raw['contestId'])
      next unless contest

      Problem.find_or_create(
        contest_id: contest.id,
        level: raw['index'],
        name: raw['name'],
        url: "http://codeforces.com/contest/#{contest.raw_id}/problem/#{raw['index']}"
      )
    end
  end
end

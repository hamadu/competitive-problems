require 'net/http'
require 'json'
require 'sequel'
require 'active_support'
require 'active_support/core_ext'

DB = Sequel.sqlite('db/problems.db')

require_relative 'app/model/platform'
require_relative 'app/model/contest'
require_relative 'app/model/problem'

require_relative 'app/fetch/codeforces'
require_relative 'app/fetch/atcoder'

# Codeforces.fetch_contests
# Codeforces.fetch_problems
#
# p Contest.count
# p Problem.count

AtCoder.fetch_regular_contests('arc')

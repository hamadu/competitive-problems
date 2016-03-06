require 'net/http'
require 'json'
require 'sequel'
require 'active_support'
require 'active_support/core_ext'

DB = Sequel.sqlite('db/problems.db')

require_relative 'model/platform'
require_relative 'model/contest'
require_relative 'model/problem'

require_relative 'fetch/codeforces'
require_relative 'fetch/atcoder'

# Codeforces.fetch_contests
# Codeforces.fetch_problems
#
# p Contest.count
# p Problem.count

AtCoder.fetch_regular_contests('arc')

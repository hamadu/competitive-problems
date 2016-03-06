DB.create_table? :problems do
  primary_key :id
  foreign_key :contest_id, :contests
  String :raw_id
  String :level
  String :name
  String :url
  String :tags

  index :name
  index :tags
end

class Problem < Sequel::Model
end

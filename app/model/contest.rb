DB.create_table? :contests do
  primary_key :id
  foreign_key :platform_id, :platforms
  String :raw_id
  String :name
  String :url
  DateTime :started_at

  index :name
end


class Contest < Sequel::Model
end

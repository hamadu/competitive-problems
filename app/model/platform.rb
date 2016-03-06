DB.create_table? :platforms do
  primary_key :id
  String :name
  String :url
end

class Platform < Sequel::Model
end

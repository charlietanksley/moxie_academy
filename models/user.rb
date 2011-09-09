class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :email, String
  property :group_id, Integer
end

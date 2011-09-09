class Group
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :password, String

  has n, :users
  validates_uniqueness_of :name
  validates_presence_of   :password 
end

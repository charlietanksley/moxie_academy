class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :email, String
  property :group_id, Integer

  belongs_to :group
  validates_presence_of   :email
  validates_presence_of   :group_id
end

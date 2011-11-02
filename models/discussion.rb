class Discussion
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :group_id, Integer

  validates_presence_of :group_id
end

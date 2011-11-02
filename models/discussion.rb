class Discussion
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :group_id, Integer
end

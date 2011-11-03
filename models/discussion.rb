class Discussion
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :group_id, Integer

  validates_presence_of :group_id

  has n, :comments

  def self.discussion_for(group_id)
    first(:group_id => group_id).comments
  end
end

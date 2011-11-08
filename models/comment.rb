class Comment
  include DataMapper::Resource

  # property <name>, <type>
  property :id,             Serial
  property :discussion_id,  Integer
  property :user_id,        Integer
  property :body,           Text
  property :created_at,     DateTime, :default => DateTime.now

  validates_presence_of :discussion_id
  validates_presence_of :user_id

  belongs_to :user
  belongs_to :discussion
end

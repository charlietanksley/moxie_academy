class Lesson
  include DataMapper::Resource

  # property <name>, <type>
  property :id,           Serial
  property :title,        String
  property :slug,         String, :format => /^[-_a-zA-Z0-9]+$/
  property :body,         Text
  property :video_title,  String
  property :poster_name,  String

  has n, :groups, :through => Resource

  validates_presence_of   :video_title
  validates_presence_of   :slug
  validates_uniqueness_of :slug

  ### DOES NOT REALLY BELONG HERE
  def body_as_html
    markdown = MarkdownPresenter.new(body)
    markdown.convert_to_html
  end
end

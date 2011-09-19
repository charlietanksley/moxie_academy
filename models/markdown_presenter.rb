require 'rdiscount'
class MarkdownPresenter
  def initialize(text)
    @text = text
  end
  
  def convert_to_html
    markdown = RDiscount.new(@text)
    markdown.to_html
  end
end

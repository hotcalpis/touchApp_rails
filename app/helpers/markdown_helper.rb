# frozen_string_literal: true

module MarkdownHelper
  def markdown_to_html(text)
    unless @markdown
      options = {
        filter_html: true,
        hard_wrap: true,
        space_after_headers: true
      }
      extensions = {
        no_intra_emphasis: true,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        superscript: true
      }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end
end

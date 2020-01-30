# frozen_string_literal: true

require 'rouge/plugins/redcarpet'

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

module MarkdownHelper
  def markdown_to_html(text)
    unless @markdown
      options = {
        filter_html: true,
        hard_wrap: true,
        space_after_headers: true
      }
      extensions = {
        autolink: true,
        fenced_code_blocks: true,
        highlight: true,
        lax_spacing: true,
        no_intra_emphasis: true,
        quote: true,
        # safe_links_only: true,
        superscript: true,
        strikethrough: true,
        tables: true
      }
      renderer = HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end
end

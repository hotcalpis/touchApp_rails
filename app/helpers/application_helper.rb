# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      title: 'touchApp',
      # description: "touchAppは作成したアプリケーションを紹介するための記事投稿サイトです",
      # keywords:    "Rails,PHP,Python",
      # icon: image_url("favicon.ico"),
      # noindex: ! Rails.env.production?,
      charset: 'UTF-8'
    }
  end
end

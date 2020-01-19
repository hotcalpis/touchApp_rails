# frozen_string_literal: true

module ApplicationHelper

  def default_meta_tags
    {
      title:       "touchApp",
      #description: "description",
      #keywords:    "Ruby,Meta,Tags",
      #icon: image_url("favicon.ico"),
      #noindex: ! Rails.env.production?,  
      charset: "UTF-8"
    }
  end
end

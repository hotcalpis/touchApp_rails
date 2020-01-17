# frozen_string_literal: true

module UsersHelper
  # def display_user_avatar(user, size)
  #   link_to user_path(user) do
  #     if user.avatar.attached?
  #       image_tag user.avatar, size: size, class: 'avatar'
  #     else
  #       image_tag 'default_avatar', size: size, class: 'avatar'
  #     end
  #   end
  # end

  def display_user_avatar(user, width, height)
    if user.avatar.attached?
      image_tag user.avatar.variant(combine_options: { resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0", gravity: :center }).processed, class: 'avatar'
    else
      image_tag 'default_avatar', size: "#{width}x#{height}", class: 'avatar'
    end
  end
end

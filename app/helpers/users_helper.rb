module UsersHelper
  def gravatar_for user, options = {size: Settings.image_size}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = if user.avatar? 
      user.avatar
    else 
      "https://secure.gravatar.com/avatar/#{gravatar_id}" 
    end
    image_tag gravatar_url, alt: user.name, class: "gravatar", size: "#{size}x#{size}", id: "user_image"
  end

  def current_user? user
    current_user == user
  end
end

class User < ApplicationRecord
  def self.from_google(google_info)
    email = google_info.emails.first.value
    find_or_create_by(email: email) do |user|
      user.name = google_info.display_name
      user.image_url = google_info.image.url
      user.google_id = google_info.id
    end
  end
end

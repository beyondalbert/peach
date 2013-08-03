module UsersHelper

  def user_to_hash(user, type)
	picture_ids = user.pictures.collect(&:id) unless user.pictures.empty?
    if type == 1
      value = {
        "id" => user.id,
        "email" => user.email,
        "longitude" => user.longitude,
        "latitude" => user.latitude,
        "location" => user.location,
		"picture_ids" => picture_ids
      }
    elsif type == 2
      value = {
        "id" => user.id,
        "email" => user.email,
        "longitude" => user.longitude,
        "latitude" => user.latitude,
        "location" => user.location,
		"picture_ids" => picture_ids
      }
    end
  end
end

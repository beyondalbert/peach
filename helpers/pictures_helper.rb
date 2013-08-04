module PicturesHelper

  def picture_to_hash(picture, type)
    if type == 1
      value = {
        "id" => picture.id,
        "user_id" => picture.user_id,
        "name" => picture.name,
				"size" => picture.size,
				"note" => picture.note,
				"logitude" => picture.logitude,
        "latitude" => picture.latitude,
        "location" => picture.location,
      }
    elsif type == 2
      value = {
        "id" => picture.id,
        "user_id" => picture.user_id,
        "name" => picture.name,
				"note" => picture.note,
      }
    end
  end
end

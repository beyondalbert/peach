require 'rubygems'
require 'typhoeus'
require 'json'

host = "http://localhost:3000/peach/"
# host = "http://www.qiu-chu.com/peach/"

res_dev1_login = Typhoeus.post(host + "users/login",
										 	params: {email: "dev1@sina.com", password: "123456"})
if res_dev1_login.code == 202
  dev1_token = JSON.parse(res_dev1_login.body)["token"]
	dev1_id = JSON.parse(res_dev1_login.body)["id"]
else
  p "error found in dev1 login, error code: #{res_dev1_login.code}"
  return
end

res_dev2_login = Typhoeus.post(host + "users/login",
									   params: {email: "dev2@sina.com", password: "123456"})
if res_dev2_login.code == 202
  dev2_token = JSON.parse(res_dev2_login.body)["token"]
else
  p "error found in dev2 login, error code: #{res_dev2_login.code}"
  return
end

res_new_user_picture_401 = Typhoeus.post(host + "pictures",
															 	params: {user_id: dev1_id, note: "test1234", key: dev2_token},
																body: {file: File.open("test.png", "r")})
if res_new_user_picture_401.code == 401
	p "new user picture 401 success"
else
	p "error found in new user picture 401, error code: #{res_new_user_picture_401.code}"
end

res_new_user_picture = Typhoeus.post(host + "pictures",
													 	params: {user_id: dev1_id, note: "test1234", key: dev1_token},
														body: {file: File.open("test.png", "r")})
if res_new_user_picture.code == 201
  p "new user picture success"
	pic_id = JSON.parse(res_new_user_picture.body)["id"]
else
  p "error found in new user picture, error code: #{res_new_user_picture.code}"
end

res_get_picture_info = Typhoeus.get(host + "pictures/#{pic_id}",
                            params: {key: dev1_token})
if res_get_picture_info.code == 200
  p "get picture info success"
  p JSON.parse(res_get_picture_info.body)
  pic_id = JSON.parse(res_get_picture_info.body)["id"]
else
  p "error found in get picture info, error code: #{res_get_picture_info.code}"
end

res_get_pictures = Typhoeus.get(host + "pictures",
                        params: {key: dev1_token})
if res_get_pictures.code == 200
  p JSON.parse(res_get_pictures.body)
  p "get pictures success"
else
  p "error found in get pictures, error code: #{res_get_pictures.code}"
end

res_down_picture_small = Typhoeus.get(host + "pictures/down/#{pic_id}",
															params: {key: dev1_token, size: "small"})
if res_down_picture_small.code == 200
  p "down picture small success"
  File.open("1small.png", "wb") {|f| f.syswrite(res_down_picture_small.body)}
else
  p "error found in down small picture, error code: #{res_down_picture_small.code}"
end

res_down_picture = Typhoeus.get(host + "pictures/down/#{pic_id}",
												params: {key: dev1_token})
if res_down_picture.code == 200
  p "down picture success"
  File.open("1.png", "wb") {|f| f.syswrite(res_down_picture.body)}
else
  p "error found in down picture, error code: #{res_down_picture.code}"
end

res_delete_user_picture_401 = Typhoeus.delete(host + "pictures/#{pic_id}",
																		params: {key: dev2_token})
if res_delete_user_picture_401.code == 401
  p "delete user picture 401 success"
else
	p "error found in delete user 401 picture, error code: #{res_delete_user_picture_401.code}"
end

res_delete_user_picture = Typhoeus.delete(host + "pictures/#{pic_id}",
																params: {key: dev1_token})
if res_delete_user_picture.code == 202
  p "delete user picture success"
else
  p "error found in delete user picture, error code: #{res_delete_user_picture.code}"
end

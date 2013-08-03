require 'rubygems'
require 'typhoeus'
require 'json'

host = "http://localhost:3000/peach/"
# host = "http://www.qiu-chu.com/peach/"

res_signup = Typhoeus::Request.post(host + "users/signup", 
				:params => {:email => "test123456789@sina.com", :password => "123456", :password_c => "123456"})
if res_signup.code == 201
  p JSON.parse(res_signup.body)
  token = JSON.parse(res_signup.body)["token"]
  p "signup success!"
else
  p "error found in signup, error code: #{res_signup.code}"
end

res_login_email_fail = Typhoeus::Request.post(host + "users/login",
						  	:params => {:email => "testyuqifeng@sina.com", :password => "123456"})
if res_login_email_fail.code == 404
  p "login email fail success!"
else
  p "error found in login, error code: #{res_login_email_fail.code}"
end

res_login_password_fail = Typhoeus::Request.post(host + "users/login",
							 	:params => {:email => "test123456789@sina.com", :password => "1234567"})
if res_login_password_fail.code == 401
  p "login password fail success!"
else
  p "error found in login, error code: #{res_login_password_fail.code}"
end

res_login = Typhoeus::Request.post(host + "users/login",
			   	:params => {:email => "test123456789@sina.com", :password => "123456"})
if res_login.code == 202
  token = JSON.parse(res_login.body)["token"]
  user_id = JSON.parse(res_login.body)["id"]
  p "login success!"
else
  p "error found in login, error code: #{res_login.code}"
end

res_dev1_login = Typhoeus.post(host + "users/login",
				     params: {email: "dev1@sina.com", password: "123456"})
if res_dev1_login.code == 202
  dev1_token = JSON.parse(res_dev1_login.body)["token"]
else
  p "error found in dev1 login, error code: #{res_dev1_login.code}"
end

res_change_password_401 = Typhoeus::Request.post(host + "users/change_password",
						     :params => {:old_password => "12345", 
						     :new_password => "abcdef", 
						     :new_password_c => "abcdef",
						     :key => token})
if res_change_password_401.code == 401
  p "change password 401 sucess"
else
  p "error found in change password 401, error code: #{res_change_password_401.code}"
end

res_change_password = Typhoeus::Request.post(host + "users/change_password",
					 	:params => {:old_password => "123456", 
						:new_password => "abcdef", 
						:new_password_c => "abcdef",
						:key => token})
if res_change_password.code == 202
  token = JSON.parse(res_change_password.body)["token"]
  p "change password success"
else
  p "error found in change password, error code: #{res_change_password.code}"
end

res_info = Typhoeus::Request.get(host + "users/#{user_id}",
			 	:params => {:key => token})
if res_info.code == 200
  p JSON.parse(res_info.body)
  p "get user info success"
else
  p "error found in get user info, error code: #{res_info.code}"
end

res_user_delete_401 = Typhoeus::Request.delete(host + "users/#{user_id}",
						   	:params => {:key => dev1_token})
if res_user_delete_401.code == 401
  p "delete self 401 success"
else
  p "error found in delete user self, error code: #{res_user_delete_401.code}"
end

res_user_delete = Typhoeus::Request.delete(host + "users/#{user_id}",
					   	:params => {:key => token})
if res_user_delete.code == 202
  p "delete self success"
else
  p "error found in delete user self, error code: #{res_user_delete.code}"
end


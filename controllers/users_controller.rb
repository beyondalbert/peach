class UsersController < ApplicationController

  helpers UsersHelper

  before do
    content_type :json
  end

  before do
    pass if ["signup", "login"].include? request.path_info.split('/')[1]
    @current_user ||= User.find_by_token(params[:key]) unless params[:key].nil?
    error 401 unless @current_user
  end

  # 参数：params[:email] params[:password] params[:password_c]
  # 用法：http://localhost:3000/users/signup?email=test@sina.com&password=123456&password_c=123456
  # 返回值：注册成功：返回新注册的用户json，并且http状态为201
  #       数据库存储失败：返回http状态为500
  post '/signup' do
    @user = User.new(:email => params[:email])
    @user.password_salt = BCrypt::Engine.generate_salt
    @user.password_hash = BCrypt::Engine.hash_secret(params[:password], @user.password_salt)
    @user.token = SecureRandom.hex
    if @user.save
      status 201
      @user.to_json
    else
      status 500
    end
  end

  # 参数：params[:email] params[:password]
  # 用法：http://localhost:3000/users/login?email=test@sina.com&password=123456
  # 返回值：登录成功：返回登录的用户json，并且http状态为202
  #        登录失败：返回http状态为401
  #        用户名不存在：返回http状态为404
  post '/login' do
    if @user = User.find_by_email(params[:email])
      if @user.password_hash == BCrypt::Engine.hash_secret(params[:password], @user.password_salt)
        status 202
        @user.to_json
      else
        status 401
      end
    else
      status 404
    end
  end

  # 参数：params[:key] params[:old_password] params[:new_password] params[:new_password_c]
  # 用法：http://localhost:3000/users/change_password?old_password=123456&new_password=abcdef&new_password_c=abcdef&key=5408afee03ca8c52a780570a4322cae3
  # 返回值：用户认证失败及旧密码不正确：返回http状态为401
  #        密码更新成功：返回更新的用户json，并且http状态为202
  #        数据库存储失败：返回http状态为500
  post '/change_password' do
    if @current_user.password_hash == BCrypt::Engine.hash_secret(params[:old_password], @current_user.password_salt)
      @current_user.password_hash = @current_user.password_hash = BCrypt::Engine.hash_secret(params[:new_password], @current_user.password_salt)    
      if @current_user.save
        status 202
        @current_user.to_json
      else
        status 500
      end
    else
      status 401
    end
  end

  # 功能：返回特定id的用户信息
  # 参数：params[:id] params[:key]
  # 用法：http://localhost:3000/users/1?key=5408afee03ca8c52a780570a4322cae3
  # 返回值： 获取用户信息成功：返回用户数据，http状态为200
  # 说明：params[:key]为可选，只有当前用户的id == 被获取的用户的id时，才返回用户的所有信息，
  #       其他则只返回用户的email、地址信息和照片
  get '/:id' do
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      value = user_to_hash(@user, 1)
    else
      value = user_to_hash(@user, 2)
    end
    value.to_json
  end

  # 功能：删除自己的账户
  # 参数：params[:id] params[:key]
  # 用法：http://localhost:3000/users/1?key=5408afee03ca8c52a780570a4322cae3
  # 返回值： 用户认证通过并且删除成功：返回http状态为202
  #         用户认证失败：返回http状态为401
  # 说明： 只有自己才能删除自己的帐号
  delete '/:id' do
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      @user.destroy
      status 202
    else
      error 401
    end 
  end
end

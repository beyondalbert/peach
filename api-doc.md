# 接口文档

## 用户接口

### 用户注册

* 接口url[post]: http://www.qiu-chu.com/peach/users/signup
* 参数： params[:email] params[:password] params[:password_c]
* curl示例：
curl -d “email=test@sina.com&password=123456&password_c=123456” http://www.qiu-chu.com/peach/users/signup
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>201</td><td>新注册的用户json</td>
  </tr>
  <tr>
    <td>500</td><td>数据库存储失败或代码内部错误</td>
  </tr>
</table>

### 用户登录
* 接口url[post]: http://www.qiu-chu.com/peach/users/login
* 参数： params[:email] params[:password]
* curl示例：curl -d “email=test@sina.com&password=123456” http://www.qiu-chu.com/peach/users/login
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>202</td><td>登录用户json</td>
  </tr>
  <tr>
    <td>401</td><td>登录失败</td>
  </tr>
  <tr>
    <td>404</td><td>用户名不存在</td>
  </tr>
</table>

### 用户修改密码
* 接口url[post]: http://www.qiu-chu.com/peach/users/change_password
* 参数： params[:key] params[:old_password] params[:new_password] params[:new_password_c]
* curl示例：curl -d “old_password=123456&new_password=abcdef&new_password_c=abcdef&key=5408afee03ca8c52a780570a4322cae3” http://www.qiu-chu.com/peach/users/change_password
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>202</td><td>修改成功，返回更新用户json</td>
  </tr>
  <tr>
    <td>401</td><td>用户认证失败及旧密码不正确</td>
  </tr>
  <tr>
    <td>500</td><td>数据库存储失败</td>
  </tr>
</table>

### 返回特定用户信息
* 接口url[get]: http://www.qiu-chu.com/peach/users/:id
* 参数： params[:id] params[:key]
* curl示例：curl http://www.qiu-chu.com/users/1?key=5408afee03ca8c52a780570a4322cae3
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>200</td><td>用户json</td>
  </tr>
  <tr>
    <td>401</td><td>用户认证失败</td>
  </tr>
</table>
* 说明：
只有当前用户的id == 被获取的用户的id时，才返回用户的所有信息，其他则只返回用户的email、地址信息和照片

### 删除自己的账户
* 接口url[delete]: http://www.qiu-chu.com/peach/users/:id
* 参数： params[:id] params[:key]
* curl示例：curl -X DELETE http://www.qiu-chu.com/users/1?key=5408afee03ca8c52a780570a4322cae3
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>202</td><td>删除成功</td>
  </tr>
  <tr>
    <td>401</td><td>用户认证失败</td>
  </tr>
</table>
* 说明：
只有自己才能删除自己的帐号

## 图片接口

### 添加图片
* 接口url[post]: http://www.qiu-chu.com/peach/pictures
* 参数： params[:key] params[:user_id] params[:note] params[:file]
* curl示例：curl -F “file=@Selection_001.png” -F “user_id=6” -F “note=test1234” http://www.qiu-chu.com/peach/pictures?key=a3adccce5b61c08d41c0e26ae9240b10
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>201</td><td>添加图片成功</td>
  </tr>
  <tr>
    <td>401</td><td>用户认证失败</td>
  </tr>
</table>

### 获取指定图片
* 接口url[get]: http://www.qiu-chu.com/peach/pictures/:id
* 参数： params[:key] params[:size]
* curl示例：
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>200</td><td>获取图片成功</td>
  </tr>
  <tr>
    <td>401</td><td>用户认证失败</td>
  </tr>
</table>

### 删除指定图片
* 接口url[delete]: http://www.qiu-chu.com/peach/pictures/:id
* 参数： params[:key]
* curl示例：curl -X DELETE http://www.qiu-chu.com/pictures/4?key=a3adccce5b61c08d41c0e26ae9240b10
* 返回值：
<table>
  <tr>
    <th>返回状态码</th><th>返回值＆说明</th>
  </tr>
  <tr>
    <td>200</td><td>删除图片成功</td>
  </tr>
  <tr>
    <td>401</td><td>用户认证失败</td>
  </tr>
</table>


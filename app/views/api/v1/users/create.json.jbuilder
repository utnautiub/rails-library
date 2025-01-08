json.success @status_code
if @error
  json.message @error[0]
else
json.message @custom_message
end
if @status_code == 1
  json.data do
    json.id @user.id
    json.name @user.name
    json.user_name @user.user_name
    json.password @user.password
    json.created_at @user.created_at
    json.updated_at @user.updated_at
    json.delete_flag @user.delete_flag
  end
end

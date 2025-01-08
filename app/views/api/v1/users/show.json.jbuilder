json.success @status_code
json.message @custom_message
if @user
  json.data do
    json.id @user.id
    json.name @user.name
    json.created_at @user.created_at
    json.updated_at @user.updated_at
    json.delete_flag @user.delete_flag
  end
end

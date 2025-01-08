json.success @status_code
json.message @custom_message
if @status_code == 1
  json.data do
    json.array! @users do |user|
      if user.delete_flag == false
        json.id user.id
        json.name user.name
        json.created_at user.created_at
        json.updated_at user.updated_at
        json.delete_flag user.delete_flag
      end
    end
  end
end
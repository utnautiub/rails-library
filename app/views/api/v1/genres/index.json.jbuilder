json.success @status_code
json.message @custom_message
json.data do
  json.array! @genres do |genre|
    if genre.delete_flag == false
      json.id genre.id
      json.name genre.name
      json.created_at genre.created_at
      json.updated_at genre.updated_at
      json.delete_flag genre.delete_flag
    end
  end
end

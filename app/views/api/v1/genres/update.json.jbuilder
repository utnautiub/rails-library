json.success @status_code
json.message @custom_message
if @status_code == 1
  json.data do
    json.id @genre.id
    json.name @genre.name
    json.created_at @genre.created_at
    json.updated_at @genre.updated_at
    json.delete_flag @genre.delete_flag
  end
end

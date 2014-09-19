json.array! @release_manager.users do |user|
  json.value "#{user.first_name} (#{user.id})"
  json.label "#{user.first_name} (#{user.id})"
end

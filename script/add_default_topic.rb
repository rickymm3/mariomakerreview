Topic.all.each do |topic|
  topic.sticky = false
  topic.locked = false
  topic.save
end
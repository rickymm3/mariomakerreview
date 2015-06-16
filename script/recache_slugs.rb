Cliq.all.each do |c|
  c.slug = nil
end
Topic.all.each do |t|
  t.slug = nil
end
Cliq.all.map(&:save)
Topic.all.map(&:save)
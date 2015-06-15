cliqs = Cliq.all

cliqs.each do |cliq|
  cliq.slug = nil
  cliq.save
end
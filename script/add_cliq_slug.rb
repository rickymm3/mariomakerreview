cliqs = Cliq.all

cliqs.each do |cliq|
  cliq.slug = cliq.name.parameterize
  cliq.save
end
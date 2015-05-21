cliqs = Cliq.all

cliqs.each do |cliq|
  cliq.cached_name = cliq.name.downcase
  cliq.name = cliq.name.capitalize
  cliq.save
end
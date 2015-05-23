cliqs = Cliq.all

cliqs.each do |cliq|
  unless cliq.id == 1
    puts cliq.name
    cliq.cliq_p_id = cliq.ancestry.split("/").last.to_i
  end

end
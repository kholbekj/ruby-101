@wins = {}
@loses = {}
while true do
  print "Enter winning team name: "
  winning_team = gets.chomp
  print "Enter losing team name: "
  losing_team = gets.chomp
  @wins[winning_team] = (@wins[winning_team] || 0) + 1
  @loses[losing_team] = (@loses[losing_team] || 0) + 1
  puts "Match registered! So far the score is:"
  puts
  (@wins.keys + @loses.keys).uniq.each do |team|
    puts team
    puts '-----'
    puts "#{@wins[team] || 0} Matches won"
    puts "#{@loses[team] || 0} Matches lost"
    puts
  end
end

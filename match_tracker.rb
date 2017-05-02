class Team
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

class Match
  def initialize(first_team, second_team, first_score, second_score)
    @first_team = first_team
    @second_team = second_team
    @first_score = first_score
    @second_score = second_score
  end

  def won?(team)
    if @first_score > @second_score
      team == @first_team
    else
      team == @second_team
    end
  end

  def score(team)
    if team == @first_team
      @first_score
    elsif team == @second_team
      @second_score
    end
  end

  def lost?(team)
    [@first_team, @second_team].include?(team) && !won?(team)
  end
end

class Tracker
  def initialize
    @teams = []
    @matches = []
  end

  def get_match
    ask_for_match
    puts "Match registered! So far the score is:"
    puts
    print_stats
  end

  private
  def ask_for_match
    print "Enter first team name: "
    first_team_name = gets.chomp
    print "Enter the score of \"#{first_team_name}\": "
    first_team_score = gets.chomp.to_i
    print "Enter second team name: "
    second_team_name = gets.chomp
    print "Enter the score of \"#{second_team_name}\": "
    second_team_score = gets.chomp.to_i

    first_team = find_or_create_team(first_team_name)
    second_team = find_or_create_team(second_team_name)

    add_match(first_team, second_team, first_team_score, second_team_score)
  end

  def print_stats
    stats = calculate_team_statistics
    stats.sort! { |t1, t2| ((t2[:won] - t2[:lost]) <=> t1[:won] - t1[:lost]) }
    stats.each do |stat|
      puts stat[:team]
      puts '-----'
      puts "#{stat[:won]} Matches won"
      puts "#{stat[:lost]} Matches lost"
      puts "#{stat[:avg]} average score"
      puts
    end
  end

  def calculate_team_statistics
    team_statistics = []
    @teams.each do |team|
      won_matches = @matches.count { |match| match.won?(team) }
      lost_matches = @matches.count { |match| match.lost?(team) }
      total_score = @matches.reduce(0) { |collector, match| collector + (match.score(team) || 0) }
      average_score = total_score / (won_matches + lost_matches).to_f
      team_statistics << { team: team.name, won: won_matches, lost: lost_matches, avg: average_score.round(2) }
    end
    team_statistics
  end

  def find_or_create_team(name)
    team = @teams.find { |team| team.name == name }
    if team.nil?
      team = Team.new(name)
      @teams << team
    end

    team
  end

  def add_match(first_team, second_team, first_score, second_score)
    @matches << Match.new(first_team, second_team, first_score, second_score)
  end
end

@tracker = Tracker.new

while true do
  @tracker.get_match
end

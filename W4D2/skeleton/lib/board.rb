class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    self.place_stones
  end

  def place_stones
    @cups.each_with_index do |cup, i| 
      4.times { cup << :stone if i != 6 && i != 13}
    end
  end

  def valid_move?(start_pos)
    if [6,13].include?(start_pos) || !(0..12).include?(start_pos)
      raise 'Invalid starting cup'
    elsif @cups[start_pos].empty?
      raise 'Starting cup is empty'
    else
      true
    end
  end

  def make_move(start_pos, current_player_name)
    stone_count = @cups[start_pos].count
    @cups[start_pos] = []

    while stone_count > 0
      start_pos += 1
      start_pos = 0 if start_pos > 13
      if start_pos == 6 
        @cups[start_pos] << :stone if current_player_name == @name1
      elsif start_pos == 13
        @cups[start_pos] << :stone if current_player_name == @name2
      else  
          @cups[start_pos] << :stone
      end
      stone_count -= 1
    end

    self.render
    self.next_turn(start_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx].count == 1
      :switch
    elsif ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    else ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? { |cup| cup.empty? } || @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    player1_stones = @cups[6].length
    player2_stones = @cups[13].length

    if player1_stones == player2_stones
      :draw
    else
      player1_stones > player2_stones ? @name1 : @name2
    end   
  end
end

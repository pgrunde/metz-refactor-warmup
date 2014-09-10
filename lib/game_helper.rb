def two_three_of_a_kind(scoring_dice)
  (scoring_dice[0..2] && scoring_dice[0..2].length == 3 && scoring_dice[1..2].all? { |scoring_die| scoring_die == scoring_dice[0] }) &&
    (scoring_dice[3..5] && scoring_dice[3..5].length == 3 && scoring_dice[4..5].all? { |scoring_die| scoring_die == scoring_dice[3] })
end

def three_pairs(scoring_dice)
  scoring_dice[0] == scoring_dice[1] &&
    scoring_dice[2] == scoring_dice[3] &&
    scoring_dice[4] == scoring_dice[5] &&
    scoring_dice.length == 6 &&
    !scoring_dice.all? { |scoring_die| scoring_dice[0] == scoring_die }
end

def three_of_a_kind(scoring_dice)
(scoring_dice[0..2] && scoring_dice[0..2].length == 3 && scoring_dice[1..2].all? { |scoring_die| scoring_die == scoring_dice[0] }) ||
  (scoring_dice[1..3] && scoring_dice[1..3].length == 3 && scoring_dice[2..3].all? { |scoring_die| scoring_die == scoring_dice[1] }) ||
    (scoring_dice[2..4] && scoring_dice[2..4].length == 3 && scoring_dice[3..4].all? { |scoring_die| scoring_die == scoring_dice[2] }) ||
    (scoring_dice[3..5] && scoring_dice[3..5].length == 3 && scoring_dice[4..5].all? { |scoring_die| scoring_die == scoring_dice[3] })
end

def four_of_a_kind(scoring_dice)
  (scoring_dice[0..3] && scoring_dice[0..3].length == 4 && scoring_dice[1..3].all? { |scoring_die| scoring_die == scoring_dice[0] }) ||
    (scoring_dice[1..4] && scoring_dice[1..4].length == 4 && scoring_dice[2..4].all? { |scoring_die| scoring_die == scoring_dice[1] }) ||
    (scoring_dice[2..5] && scoring_dice[2..5].length == 4 && scoring_dice[3..5].all? { |scoring_die| scoring_die == scoring_dice[2] })
end

def five_of_a_kind(scoring_dice)
  (scoring_dice[0..4] && scoring_dice[0..4].length == 5 && scoring_dice[1..4].all? { |scoring_die| scoring_die == scoring_dice[0] }) ||
    (scoring_dice[1..5] && scoring_dice[1..5].length == 5 && scoring_dice[2..5].all? { |scoring_die| scoring_die == scoring_dice[1] })
end

def six_of_a_kind(scoring_dice)
  scoring_dice.length == 6 && scoring_dice[1..5].all? { |scoring_die| scoring_die == scoring_dice[0] }
end

def tallyin(scoring_dice)
  @tally_score += scoring_dice.count('1') * 100 if scoring_dice.count('1') > 0 && scoring_dice.count('1') < 3
  scoring_dice.delete('1')
  @tally_score += scoring_dice.count('5') * 50 if scoring_dice.count('5') > 0 && scoring_dice.count('5') < 3
  scoring_dice.delete('5')
end

def six_of_a_kind_method(scoring_dice)
  kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 6 }
  kind == '1' ? @tally_score = 1000 * 4 : @tally_score = kind.to_i * 100 * 2 * 2 * 2
  scoring_dice.delete(kind)
end

def two_three_of_a_kind_method(scoring_dice)
  kind_0 = scoring_dice[0]
  kind_1 = scoring_dice[3]
  kind_0 == '1' ? @tally_score = 1000 + kind_1.to_i * 100 : @tally_score = kind_0.to_i * 100 + kind_1.to_i * 100
  scoring_dice.clear
end

def five_of_a_kind_method(scoring_dice)
  kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 5 }
  kind == '1' ? @tally_score = 1000 * 3 : @tally_score = kind.to_i * 100 * 2 * 2
  scoring_dice.delete(kind)
end


def four_of_a_kind_method(scoring_dice)
  kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 4 }
  kind == '1' ? @tally_score = 1000 * 2 : @tally_score = kind.to_i * 100 * 2
  scoring_dice.delete(kind)
end

def three_of_a_kind_method(scoring_dice)
  kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 3 }
  kind == '1' ? @tally_score = 1000 : @tally_score = kind.first.to_i * 100
  scoring_dice.delete(kind)
end
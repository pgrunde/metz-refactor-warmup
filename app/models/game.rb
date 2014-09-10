require_relative '../../lib/game_helper'

class Game < ActiveRecord::Base
  serialize :last_roll, Array
  has_many :players

  def initialize(params)
    player_1_name = params.delete("player_1")
    player_2_name = params.delete("player_2")

    super(params)
    self.players.new(player_name: player_1_name, total_score: 0, current_score: 0)
    self.players.new(player_name: player_2_name, total_score: 0, current_score: 0)
    self.available_dice = 6
    self.player_iterator = 0
    # do our logic here?
  end

  def current_player
    if new_record?
      self.players.first
    else
      self.players.order(:id)[self.player_iterator]
    end
  end

  def roll_again(scoring_dice)
    player = current_player
    self.available_dice -= scoring_dice.length
    self.save
    score = score(scoring_dice)
    player.current_score += score
    self.available_dice = 6 if self.available_dice == 0
    self.last_roll = roll_dice if scoring_dice == [] || score > 0
    self.save
    player.save
  end

  def bust
    player = current_player
    player.current_score = 0
    player.save
  end

  def stay(scoring_dice)
    player = current_player
    self.player_iterator += 1
    self.player_iterator = 0 if self.player_iterator >= self.players.length
    self.last_roll = []
    self.available_dice = 0
    self.save
    player.total_score ||= 0
    player.current_score ||=0
    player.current_score += score(scoring_dice)
    player.total_score += player.current_score
    player.current_score = 0
    player.save
  end

  def roll_dice
    dice = {1 => '⚀',
            2 => '⚁',
            3 => '⚂',
            4 => '⚃',
            5 => '⚄',
            6 => '⚅',
    }
    (1..self.available_dice).map { rand(1..6) }.sort.map { |face| [face, dice[face]] }
  end

  def score(scoring_dice)
    straight = scoring_dice == ['1', '2', '3', '4', '5', '6']

    two_three_of_a_kind = two_three_of_a_kind_method(scoring_dice)

    three_pairs = three_pairs_method(scoring_dice)

    three_of_a_kind = three_of_a_kind_method(scoring_dice)

    four_of_a_kind =
      (scoring_dice[0..3] && scoring_dice[0..3].length == 4 && scoring_dice[1..3].all? { |scoring_die| scoring_die == scoring_dice[0] }) ||
        (scoring_dice[1..4] && scoring_dice[1..4].length == 4 && scoring_dice[2..4].all? { |scoring_die| scoring_die == scoring_dice[1] }) ||
        (scoring_dice[2..5] && scoring_dice[2..5].length == 4 && scoring_dice[3..5].all? { |scoring_die| scoring_die == scoring_dice[2] })

    five_of_a_kind =
      (scoring_dice[0..4] && scoring_dice[0..4].length == 5 && scoring_dice[1..4].all? { |scoring_die| scoring_die == scoring_dice[0] }) ||
        (scoring_dice[1..5] && scoring_dice[1..5].length == 5 && scoring_dice[2..5].all? { |scoring_die| scoring_die == scoring_dice[1] })

    six_of_a_kind =
      scoring_dice.length == 6 && scoring_dice[1..5].all? { |scoring_die| scoring_die == scoring_dice[0] }

    tally_score = 0

    if straight
      tally_score = 1500
      scoring_dice.clear
    elsif three_pairs
      tally_score = 750
      scoring_dice.clear
    elsif six_of_a_kind
      kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 6 }
      if kind == '1'
        tally_score = 1000 * 4
      else
        tally_score = kind.to_i * 100 * 2 * 2 * 2
      end
        scoring_dice.delete(kind)
    elsif two_three_of_a_kind
      kind_0 = scoring_dice[0]
      kind_1 = scoring_dice[3]
      if kind_0 == '1'
        tally_score = 1000 + kind_1.to_i * 100
      else
        tally_score = kind_0.to_i * 100 + kind_1.to_i * 100
      end
      scoring_dice.clear
    elsif five_of_a_kind
      kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 5 }
      if kind == '1'
        tally_score = 1000 * 3
      else
        tally_score = kind.to_i * 100 * 2 * 2
      end
        scoring_dice.delete(kind)
    elsif four_of_a_kind
      kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 4 }
      if kind == '1'
        tally_score = 1000 * 2
      else
        tally_score = kind.to_i * 100 * 2
      end
        scoring_dice.delete(kind)
    elsif three_of_a_kind
      kind = scoring_dice.find { |dice| scoring_dice.count(dice) == 3 }
      if kind == '1'
        tally_score = 1000
      else
        tally_score = kind.first.to_i * 100
      end
        scoring_dice.delete(kind)
    end

    tally_score += scoring_dice.count('1') * 100 if scoring_dice.count('1') > 0 && scoring_dice.count('1') < 3
    scoring_dice.delete('1')
    tally_score += scoring_dice.count('5') * 50 if scoring_dice.count('5') > 0 && scoring_dice.count('5') < 3
    scoring_dice.delete('5')

    rejected_dice = scoring_dice

    self.available_dice += rejected_dice.length
    tally_score
  end
end

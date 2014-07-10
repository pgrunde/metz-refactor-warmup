class Game < ActiveRecord::Base
  serialize :last_roll, Array

  def roll(score_dice)
    self.available_dice -= score_dice.length
    self.available_dice = 6 if self.available_dice == 0
    self.current_score = 150
    self.last_roll = roll_dice
    self.save
  end

  def stay
    self.current_score = 150
    self.total_score += self.current_score
    self.current_score = 0
    self.available_dice = 6
    self.save
  end

  def roll_dice
    dice = { 1 => '⚀',
             2 => '⚁',
             3 => '⚂',
             4 => '⚃',
             5 => '⚄',
             6 => '⚅',
    }
    (1..self.available_dice).map { rand(1..6) }.sort.map {|face| [face, dice[face]] }
  end

end

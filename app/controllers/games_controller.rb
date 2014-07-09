class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.total_score = 0
    @game.current_score = 0
    @game.available_dice = 6
    @game.last_roll = roll_dice
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    score_dice = [params[:dice_0],
             params[:dice_1],
             params[:dice_2],
             params[:dice_3],
             params[:dice_4],
             params[:dice_5],
    ].compact
    @game.available_dice -= score_dice.length
    @game.current_score = 150
    @game.save
    redirect_to game_path
  end

  private

  def roll_dice
    dice = { 1 => '⚀',
             2 => '⚁',
             3 => '⚂',
             4 => '⚃',
             5 => '⚄',
             6 => '⚅',
    }
    (1..@game.available_dice).map { rand(1..6) }.sort.map {|face| [face, dice[face]] }
  end

end

class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @available_dice ||= 6
    @roll = roll_dice

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
    fixies = (1..@available_dice).map { rand(1..6) }.sort
    fixies.map {|face| dice[face] }
  end

end

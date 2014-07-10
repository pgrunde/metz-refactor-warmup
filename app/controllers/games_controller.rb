class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.total_score = 0
    @game.current_score = 0
    @game.available_dice = 6
    @game.last_roll = @game.roll_dice
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if params[:commit] == 'Roll'
      score_dice = [params[:dice_0],
                    params[:dice_1],
                    params[:dice_2],
                    params[:dice_3],
                    params[:dice_4],
                    params[:dice_5],].compact
      @game.roll(score_dice)
    elsif params[:commit] == 'Stay'
      @game.stay
    end
    redirect_to game_path
  end

end

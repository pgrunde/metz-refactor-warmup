class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.total_score = 0
    @game.current_score = 0
    @game.last_roll = @game.first_roll
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if params[:commit] == 'Roll'
      scoring_dice = [params[:dice_0],
                    params[:dice_1],
                    params[:dice_2],
                    params[:dice_3],
                    params[:dice_4],
                    params[:dice_5],].compact
      @game.roll_again(scoring_dice)
    elsif params[:commit] == 'Stay'
      scoring_dice = [params[:dice_0],
                      params[:dice_1],
                      params[:dice_2],
                      params[:dice_3],
                      params[:dice_4],
                      params[:dice_5],].compact
      @game.stay(scoring_dice)
    else
      @game.first_roll
    end
    redirect_to game_path
  end

end

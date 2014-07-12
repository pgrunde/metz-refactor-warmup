require 'spec_helper'

describe 'User can play Ten Thousand' do

  def new_game_with_defaults
    game = Game.new
    game.total_score = 0
    game.current_score = 0
    game.last_roll = game.first_roll
    game
  end

  it 'initializes game with scores, dice available nil, no last roll' do
    game = new_game_with_defaults
    expect(game.total_score).to eq 0
    expect(game.current_score).to eq 0
    expect(game.available_dice).to eq 6
    expect(game.last_roll.size).to eq 6
  end

  it 'allows a user to roll, tracks last roll' do
    srand(1)
    game = Game.new
    game.first_roll
    actual = game.last_roll
    expected = [[1, "⚀"], [2, "⚁"], [4, "⚃"], [4, "⚃"], [5, "⚄"], [6, "⚅"]]
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to roll and then score 1s and 5s' do
    srand(1)
    game = Game.new
    game.first_roll
    game.stay(['1', '5'])
    actual = game.total_score
    expected = 150
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to roll multiple times and then score 1s and 5s' do
    srand(1)
    game = new_game_with_defaults
    game.first_roll
    game.roll_again(['1', '1', '5'])
    game.stay(['5', '5'])
    actual = game.total_score
    expected = 350
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

end

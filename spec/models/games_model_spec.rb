require 'spec_helper'

describe 'User can play Ten Thousand' do

  it 'initializes game with scores, dice available nil, no last roll' do
    game = Game.new
    expect(game.total_score).to eq nil
    expect(game.current_score).to eq nil
    expect(game.available_dice).to eq nil
    expect(game.last_roll).to eq []
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

  it 'allows a user to roll and then score' do
    srand(1)
    game = Game.new
    game.first_roll
    game.stay([[1, "⚀"], [5, "⚄"]])
    actual = game.total_score
    expected = 150
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

end

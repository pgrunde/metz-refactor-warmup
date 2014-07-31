require 'spec_helper'

feature 'Users can play Ten Thousand' do

  before do
    srand(1)
  end
  after do
    srand(Random.new_seed)
  end

  scenario 'Users play' do
    create_user
    login_user
    visit '/'
    click_link 'New Game'
    fill_in 'Player 1', :with => 'Albert'
    fill_in 'Player 2', :with => 'Emily'
    click_on "Let's Play!"

    within('.total_scores') do
      expect(page).to have_content("Albert's Total Score: 0")
      expect(page).to have_content("Emily's Total Score: 0")
    end
    expect(page).to have_content('Albert, you are up!')

    within('.current_game') do
      expect(page).to have_content('Current Score: 0')
    end

    click_on "Roll"
    expect(page).to have_content('⚀ ⚁ ⚃ ⚃ ⚄ ⚅')
    check 'dice_0'
    check 'dice_4'
    click_on "Roll"
    expect(page).to have_content('⚀ ⚀ ⚁ ⚅')
    expect(page).to have_content('Current Score: 150')
    check 'dice_0'
    check 'dice_1'
    click_on 'Stay'
    expect(page).to have_content('Current Score: 0')
    expect(page).to have_content('Albert\'s Total Score: 350')
    expect(page).to have_content('Emily, you are up!')
    expect(page).to_not have_content('You rolled:')
    click_on 'Roll'
    expect(page).to have_content('⚁ ⚂ ⚄ ⚄ ⚄ ⚅')
    check 'dice_2'
    check 'dice_3'
    check 'dice_4'
    click_on 'Roll'
    expect(page).to have_content('⚂ ⚄ ⚅')
    check 'dice_1'
    click_on 'Stay'
    expect(page).to have_content('Emily\'s Total Score: 550')
    expect(page).to have_content('Albert, you are up!')
    click_on 'Roll'
    expect(page).to have_content('⚂ ⚂ ⚃ ⚄ ⚄ ⚅')
    check 'dice_3'
    check 'dice_4'
    click_on 'Roll'
    expect(page).to have_content('⚀ ⚁ ⚁ ⚄')
    check 'dice_0'
    check 'dice_3'
    click_on 'Roll'
    expect(page).to have_content('⚁ ⚅')
    expect(page).to have_content('Current Score: 0')
    click_on('Awww, man!')
    expect(page).to have_content('Albert\'s Total Score: 350')
    expect(page).to have_content('Emily, you are up!')
    click_on 'Roll'
    expect(page).to have_content('⚀ ⚁ ⚁ ⚁ ⚄ ⚅')
    click_on 'Roll'
    expect(page).to have_content('⚀ ⚁ ⚁ ⚁ ⚄ ⚅')
  end


=begin
  before do
    srand(3)
    create_user
    login_user
    visit '/'
    click_link 'New Game'
    click_link "Let's Play!"
  end

  after do
    srand(Random.new_seed)
  end

  scenario 'New game has defaults of total and current score 0, available dice 6' do
    expect(page).to have_content('Total Score: 0')
    expect(page).to have_content('Current Score: 0')
    expect(page).to have_content('Available Dice: 6')
  end

  scenario 'User can choose dice to keep' do
    expect(page).to have_content('You rolled: ⚀ ⚀ ⚀ ⚁ ⚂ ⚃')
    check 'dice_0'
    check 'dice_1'
    check 'dice_2'
    click_button 'Roll'
    expect(page).to have_content('Current Score: 1000')
  end

  scenario 'User can stop rolling and take score' do
    expect(page).to have_content('You rolled: ⚀ ⚀ ⚀ ⚁ ⚂ ⚃')
    check 'dice_0'
    check 'dice_1'
    check 'dice_2'
    click_button 'Stay'
    expect(page).to have_content('Total Score: 1000')
  end

  scenario 'If user busts, current score=0, available dice=6, user can play again' do
    expect(page).to have_content('You rolled: ⚀ ⚀ ⚀ ⚁ ⚂ ⚃')
    check 'dice_0'
    check 'dice_1'
    check 'dice_2'
    click_button 'Roll'
    expect(page).to have_content('Current Score: 1000')
    expect(page).to have_content('Available Dice: 3')
    check 'dice_0'
    click_button 'Roll'
    expect(page).to have_content('Current Score: 0')
    expect(page).to have_content('Available Dice: 6')
    expect(page).to have_content('Bust!')
    expect(page).to_not have_button('Roll')
    expect(page).to_not have_button('Stay')
  end
=end

end

require 'spec_helper'

feature 'User can play one hand of Ten Thousand' do

  scenario 'User can start a new game' do
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    click_link 'New Game'
    click_link 'Let\'s Play!'
    expect(page).to have_content('Total Score: 0')
    expect(page).to have_content('Current Score: 0')
    expect(page).to have_content('Available Dice: 6')
  end

  scenario 'User can roll all available dice' do
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    click_link 'New Game'
    click_link 'Let\'s Play!'
    expect(page).to have_content('You rolled:')
  end

  scenario 'User can choose dice to keep' do
    srand(1)
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    click_link 'New Game'
    click_link 'Let\'s Play!'
    expect(page).to have_content('You rolled: ⚀ ⚁ ⚃ ⚃ ⚄ ⚅')
    check 'dice_0'
    check 'dice_4'
    click_button 'Roll'
    expect(page).to have_content('Current Score: 150')
    srand(Random.new_seed)
  end

end

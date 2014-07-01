require 'spec_helper'

feature 'User login' do

  scenario 'User is welcomed on homepage' do
    visit '/'
    expect(page).to have_content('Welcome to the Game of TenThousand')
  end

  scenario 'User can register' do
    visit '/'
    click_on 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_on 'Register'
    expect(page).to have_content('Albert, welcome to your Game of TenThousand')
    expect(page).to_not have_content('Register')
  end

end

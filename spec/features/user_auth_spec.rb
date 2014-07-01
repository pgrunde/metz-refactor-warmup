require 'spec_helper'

feature 'User login' do
  scenario 'User is welcomed on homepage' do
    visit '/'
    expect(page).to have_content('Welcome to the Game of TenThousand')
  end

end

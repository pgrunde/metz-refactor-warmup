def login_user
  visit '/'
  click_on 'Log in'
  fill_in 'Email', :with => 'user@example.com'
  fill_in 'Password', :with => 'password'
  click_button 'Log in'
end

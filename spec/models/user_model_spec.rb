require 'spec_helper'

describe User do

  it 'User can be created' do
    username = 'Albert'
    email = 'albert@example.com'
    password = 'password'
    User.create(:username => username, :email => email, :password => password)
    actual = User.find_by_email(email) != nil
    expect(actual).to eq(true)
  end

  it 'User cannot register with already taken email' do
    username = 'Albert'
    email = 'albert@example.com'
    password = 'password'
    User.create(:username => username, :email => email, :password => password)
    User.create(:username => 'Other Person', :email => email, :password => password)
    expect(User.all.length).to eq(1)
    expect(User.find_by_email(email).username).to eq('Albert')
  end

end

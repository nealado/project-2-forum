require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'
  #describes a thing
RSpec.describe 'Login Feature', type: :feature do
    #it means the thing does a thing
  it "works" do
    User.create(email: 'test', password: 'test')
    visit '/'
    find('input[name="email"]').set('test')
    find('input[name="password"]').set('test')
    find('input[type="submit"]').click
    expected_path = topics_path
  end
end

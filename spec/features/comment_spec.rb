require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.describe 'Comment Feature', type: :feature do

  it "works" do
    User.create(email: 'test', password: 'test')
    visit '/'
    find('input[name="email"]').set('test')
    find('input[name="password"]').set('test')
    find('input[type="submit"]').click
    click_on 'New Topic'
    find('input[name="topic[title]"]').set('test')
    find('textarea[name="topic[content]"]').set('Ipsum lorem hipstum')
    find('input[name="commit"]').click
    visit = '/topics/:id'
    find('input[name="comment[title]"]').set('test comment')
    find('textarea[name="comment[content]"]').set('test comment body')
    find('input[name="commit"]').click
    page.has_content?('test comment body')
  end

end

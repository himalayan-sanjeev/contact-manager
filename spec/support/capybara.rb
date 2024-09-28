require 'capybara/rspec'

Capybara.default_max_wait_time = 5
Capybara.server = :puma

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome
  end
end

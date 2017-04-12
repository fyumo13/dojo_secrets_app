def log_in email: "email@gmail.com", password: "password"
  visit '/sessions/new' unless current_path == "/sessions/new"
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log In'
end

def register name: "Fredrik Yumo", email: "email@gmail.com", password: "password"
  visit "/users/new" unless current_path == "/users/new"
  fill_in 'name', with: name
  fill_in 'email', with: email
  fill_in 'password', with: password
  fill_in 'password_confirmation', with: password
  click_button 'Register'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

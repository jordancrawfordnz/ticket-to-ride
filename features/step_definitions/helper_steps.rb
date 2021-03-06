When(/^the user is on the root page$/) do
  visit('/')
end

When(/^the (?:user|player) clicks the "([^"]*)" link$/) do |text|
  click_link(text)
end

When(/^the (?:user|player) clicks the "([^"]*)" button$/) do |text|
  click_button(text)
end

Then(/^the (?:user|player) sees an error "(.*)"$/) do |error_text|
  expect(page).to have_content error_text
end

Then(/^the (?:user|player) sees the text "(.*)"$/) do |text|
  expect(page).to have_content text
end

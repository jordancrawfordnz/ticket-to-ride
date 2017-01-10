When(/^the user is on the root page$/) do
  visit_root_page
end

When(/^clicks the "([^"]*)" button$/) do |text|
  click_button(text)
end

When(/^clicks the "([^"]*)" link$/) do |text|
  click_link(text)
end

Then(/^the user sees an error "([^"]*)"$/) do |error_text|
  expect(page).to have_content error_text
end

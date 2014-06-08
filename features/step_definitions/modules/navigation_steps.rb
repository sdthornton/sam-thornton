When(/^I (?:visit|go to|am on) (.+)$/) do |page_name|
  visit path_to(page_name)
end

Then(/^I should be on (.+)$/) do |page_name|
  assert_equal path_to(page_name), page.current_path
end

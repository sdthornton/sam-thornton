When(/^I (?:click|click on|press) `(.*)`$/) do |link|
  click_on link
end

Then(/^I should see (?:a|an) '(.*)' error message$/) do |error|
  assert page.has_content?(error),
    "Should show '#{error}' error message"
end

def define_admin_attrs
  @admin_attrs = {
    email: "admin@email.com",
    password: "testing123"
  }
end

def find_admin
  define_admin_attrs
  @admin = Admin.find_by_email @admin_attrs[:email]
end

def delete_admin
  find_admin
  @admin.destroy unless @admin.nil?
end

def create_admin
  delete_admin
  @admin = create(:admin, @admin_attrs)
end

def sign_in_admin
  create_admin
  login_as(@admin, scope: :admin)
end

def sign_out_admin
  logout(:admin)
end

Given(/^I am not (?:signed|logged) in$/) do
  sign_out_admin
end

Given(/^I exist as an admin user$/) do
  create_admin
end

Given(/^I am (?:signed|logged) in$/) do
  sign_in_admin
end

When(/^I enter my credentials$/) do
  find_admin
  fill_in 'Email', with: @admin_attrs[:email]
  fill_in 'Password', with: @admin_attrs[:password]
end

When(/^I enter invalid credentials$/) do
  fill_in 'Email', with: 'fake@email.com'
  fill_in 'Password', with: 'foobar'
end

When(/^I attempt to (?:sign|log) in with an invalid password(?:$| again$)/) do
  create_admin unless @admin.present?
  fill_in 'Email', with: @admin_attrs[:email]
  fill_in 'Password', with: 'foobar'
  step 'I click `Sign In`'
end

Then(/^I should be (?:signed|logged) in as an admin user$/) do
  assert page.has_content?('Signed in successfully.'),
    'Should show that I am signed in'
end

Then(/^I should be (?:signed|logged) out$/) do
  assert page.has_content?('Signed out successfully.'),
    'Should show that I am signed out'
end

Then(/^I should not be able to (?:sign|log) in for (.+)$/) do |time|
  step 'I enter my credentials'
  step 'I click `Sign In`'
  step "I should see a 'Your account is locked' error message"
  Delorean.time_travel_to "#{time} from now"
  step 'I enter my credentials'
  step 'I click `Sign In`'
  step 'I should be signed in as an admin user'
end

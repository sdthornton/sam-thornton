FactoryGirl.define do

  factory :message do
    name { generate(:random_letters) }
    email { "#{generate(:random_string)}@email.com" }
    subject { generate(:random_string) }
    body { "This is a valid test message" }
  end
end

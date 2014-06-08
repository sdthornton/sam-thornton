FactoryGirl.define do
  
  factory :admin do
    email { "#{generate(:random_string)}@email.com".downcase }
    password { "testing123" }

    password_confirmation 0
    after(:build) do |admin, evaluator|
      admin.password_confirmation = admin.password_confirmation == 0 ? admin.password : evaluator.password_confirmation
    end
  end

end

FactoryGirl.define do

  factory :slug do
    association :post
    url { generate(:random_letters) }
  end
end

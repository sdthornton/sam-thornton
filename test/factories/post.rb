FactoryGirl.define do

  factory :post do
    title { generate(:random_letters) }
    content { generate(:random_letters) }
  end
end

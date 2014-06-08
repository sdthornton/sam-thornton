FactoryGirl.define do

  factory :post do
    title { generate(:random_letters) }
    content { generate(:random_string) }
  end
end

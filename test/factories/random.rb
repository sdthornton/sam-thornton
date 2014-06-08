FactoryGirl.define do
  sequence(:random_string) { SecureRandom.hex(3) }
  sequence(:random_letters) { ('a'..'z').to_a.sample(6).join }
end

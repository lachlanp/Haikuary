# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bad_haiku do
    author "MyString"
    description "MyString"
    syllable_estimate 1
    converted false
  end
end

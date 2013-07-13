FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :question do
    sequence(:title)   { |n| "Lorem ipsum #{n}" }
    sequence(:content) { |n| "This is question #{n}." }
    tag_list "#chinese #english #math"
    user
  end

  factory :answer do
    sequence(:content) { |n| "This is answer #{n}." }
    user
    question
  end
end
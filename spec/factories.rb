FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :question do
    title "Lorem ipsum"
    content "This is a question."
    user
  end

  factory :answer do
    content "This is an answer."
    user
    question
  end
end
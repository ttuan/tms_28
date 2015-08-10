FactoryGirl.define do
  factory :subject do
    name          {Faker::Name.name}
    description   {Faker::Name.name}
    day_work      10

    factory :invalid_subject1 do
      name        ""
    end

    factory :invalid_subject2 do
      description ""
    end

    factory :invalid_subject3 do
      day_work    ""
    end
  end
end

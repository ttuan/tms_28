FactoryGirl.define do
  factory :course do
    name          {Faker::Name.name}
    description   {Faker::Name.name}
    status false
    start_date {Date.today}
    day_work 0

    factory :invalid_course1 do
      name        ""
    end

    factory :invalid_course2 do
      description ""
    end
  end
end

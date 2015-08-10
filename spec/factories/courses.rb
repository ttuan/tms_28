FactoryGirl.define do
  factory :course do
    name          {Faker::Name.name}
    description   {Faker::Name.name}

    factory :invalid_course1 do
      name        ""
    end

    factory :invalid_course2 do
      description ""
    end
  end
end

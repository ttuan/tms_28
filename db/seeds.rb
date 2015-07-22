User.create!(name: "Admin",
              email: "admin@gmail.com",
              avatar: "http://www.glbtrt.ala.org/news/wp-content/uploads/2015/06/Spiderman.jpg",
              password: "abcd1234",
              password_confirmation: "abcd1234",
              supervisor: true)

48.times do |n|
  name  = Faker::Name.name
  email = "test.aaaaa-#{n+1}@gmail.com"
  password = "abcd1234"
  User.create!(name: name,
              email: email,
              avatar: "http://img2.wikia.nocookie.net/__cb20100405031309/fantendo/images/5/5b/NSMBDIY_Mario_Jump.png",
              password:              password,
              password_confirmation: password)
end

Course.create!(name: "Ruby on Rails", description: "Training Ruby on Rails")
Course.create!(name: "IOS", description: "Training IOS") 
Course.create!(name: "Android", description: "Training Android")

Subject.create!(name: "Git", day_work: 2, description: "Training Git")
Subject.create!(name: "Rails Tutorial", day_work: 10, description: "Read https://www.railstutorial.org/book")
Subject.create!(name: "Project 1", day_work: 10, description: "You have 10 days to work project 1")
Subject.create!(name: "Project 2", day_work: 7, description: "You have 7 days to work project 2")
Subject.create!(name: "Rspec", day_work: 10, description: "Training Rspec")

course1 = Course.find(1)
course1.course_subjects.create!(subject_id: 1)
course1.course_subjects.create!(subject_id: 2)
course1.course_subjects.create!(subject_id: 3)
course1.course_subjects.create!(subject_id: 4)
course1.course_subjects.create!(subject_id: 5)

course2 = Course.find(2)
course2.course_subjects.create!(subject_id: 1)
course2.course_subjects.create!(subject_id: 3)
course2.course_subjects.create!(subject_id: 4)

course3 = Course.find(3)
course3.course_subjects.create!(subject_id: 1)

2.times do |n|
  Task.create!(name: "Lesson #{n}", description: "Start learn lesson #{n}", subject_id: 1)
end

10.times do |n|
  Task.create!(name: "Lesson #{n}", description: "Start learn lesson #{n}", subject_id: 2)
end

10.times do |n|
  Task.create!(name: "Lesson #{n}", description: "Start learn lesson #{n}", subject_id: 3)
end

10.times do |n|
  Task.create!(name: "Lesson #{n}", description: "Start learn lesson #{n}", subject_id: 4)
end

10.times do |n|
  Task.create!(name: "Lesson #{n}", description: "Start learn lesson #{n}", subject_id: 5)
end

(1..16).each do |n|
  user = User.find(n)
  user_course1 = user.user_courses.create!(course_id: course1.id, start_date: Time.zone.now, active: true)
  course1.course_subjects.each do |course_subject|
    user_course1.user_subjects.create!(user_id: user.id, subject_id: course_subject.subject.id, course_id: course1.id)
  end
end

(17..32).each do |n|
  user = User.find(n)
  user_course2 = user.user_courses.create!(course_id: course2.id, start_date: Time.zone.now, active: true)
  course2.course_subjects.each do |course_subject|
    user_course2.user_subjects.create!(user_id: user.id, subject_id: course_subject.subject.id, course_id: course2.id)
  end
end

(33..48).each do |n|
  user = User.find(n)
  user_course3 = user.user_courses.create!(course_id: course3.id, start_date: Time.zone.now, active: true)
  course3.course_subjects.each do |course_subject|
    user_course3.user_subjects.create!(user_id: user.id, subject_id: course_subject.subject.id, course_id: course3.id)
  end
end

course1.user_courses.each do |user_course|
  user = user_course.user
  content = Faker::Lorem.word
  5.times do
   Activity.create!(content: content, user_id: user.id, course_id: course1.id)
  end  
end

course2.user_courses.each do |user_course|
  user = user_course.user
  content = Faker::Lorem.word
  5.times do
   Activity.create!(content: content, user_id: user.id, course_id: course2.id)
  end  
end

course3.user_courses.each do |user_course|
  user = user_course.user
  content = Faker::Lorem.word
  5.times do
   Activity.create!(content: content, user_id: user.id, course_id: course3.id)
  end  
end


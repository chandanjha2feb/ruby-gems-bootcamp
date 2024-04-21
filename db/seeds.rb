user = User.new(
  email: 'student@example.com', 
  password: 'student@example.com', 
  password_confirmation: 'student@example.com'
)
user.skip_confirmation!
user.save!
PublicActivity.enabled = false
10.times do
    Course.create!([{
        title: Faker::Educator.course_name,
        description: Faker::TvShows::GameOfThrones.quote,
        user_id: user.id,
        short_description: Faker::Quote.famous_last_words,
        language: Faker::ProgrammingLanguage.name,
        level: "Beginner",
        price: Faker::Number.between(from: 1000, to: 20000)
    }])
end
PublicActivity.enabled = true


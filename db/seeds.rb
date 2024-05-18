# db/seeds.rb
10.times do
  user = User.create!(
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )

  5.times do
    Board.create!(
      user_id: user.id,
      title: Faker::Lorem.sentence(word_count: 3),
      body: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end
end
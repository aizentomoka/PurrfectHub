# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "aaa@aaa",
  password: "aaaaaa"
)


10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    password: "testtest",
    nickname: "ねこたろう#{n + 1}",
    first_name: "てすと#{n + 1}",
    last_name: "ゆーざー#{n + 1}",
    first_name_kana: "テスト#{n + 1}",
    last_name_kana: "ユーザー#{n + 1}",
    post_code: "000000#{n + 1}",
    address: "猫県猫市猫区2222#{n + 1}",
    telephone_number: "012022222#{n + 1}",
    is_active: "true"
  )
end

10.times do |n|
  Cat.create!(
    user_id: "#{n + 1}",
    name: "ねこたろう#{n + 1}号",
    birthday: ,
    sex: "オス",
  )
end


10.times do |n|
  Diary.create!(
    cat_id: "#{n + 1}",
    user_id: "#{n + 1}",
    title: "日記テスト投稿#{n + 1}",
    body: "日記テスト投稿#{n + 1}",
    weight: "2",
  )
end

10.times do |n|
  RescuedCat.create!(
    user_id: "#{n + 1}",
    name: "ねこ#{n + 1}号",
    age: "1",
    sex: "メス",
    title: "里親募集テスト投稿#{n + 1}",
    body: "里親募集テスト投稿#{n + 1}",
    is_completion: "false",
    vaccine: "未接種",
    is_castration: "false",

  )
end
namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all
    5.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
end

  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
        name: FFaker::Name.first_name,
        email: FFaker::Internet.disposable_email,
        password: FFaker::PhoneNumberDA.phone_number,
      )
    end
end

    task fake_comment: :environment do
        Comment.destroy_all
        Restaurant.all.each do |restaurant|
        3.times do |i|
        Comment.create!(restaurant_id: restaurant.id,
        user: User.all.sample,
        content:"GOOD"
        )
   end
end
end

end

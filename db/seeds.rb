User.create! name: "hai ha", email: "haiha210.gm@gmail.com", password: "123456",
password_confirmation: "123456", role: 2,
 address: FFaker::Address.street_address + ", " + FFaker::Address.city, 
 verified: true, activated_at: Time.zone.now

99.times do |n|
  name = FFaker::Name.name
  email = FFaker::Internet.email
  address = FFaker::Address.street_address + ", " + FFaker::Address.city
  avatar = FFaker::Avatar.image(slug = nil, size = '300x300', format = 'png', bgset = nil)
  password = "123456"
  phone = FFaker::PhoneNumber.phone_number
  birthday = FFaker::Time.between 50.year.ago, 20.year.ago
  User.create! name: name, email: email, password: password, password_confirmation: password,
    verified: true, activated_at: Time.zone.now, address: address, phone: phone, birthday: birthday
end

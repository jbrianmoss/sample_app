# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :event do |event|
  event.name "Open Mike Night"
  event.description "Open Mike Night at the Foo Bar and Grill"
  event.start_time Time.now
  event.end_time Time.now
  event.stop_sales Time.now
  event.quantity 50
  event.price 9.50
  event.currency "CAD"
  event.max_tix 5

  event.association :user
end


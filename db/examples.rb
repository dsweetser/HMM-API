# frozen_string_literal: true
# This file should contain all the record creation needed to experiment with
# your app during development.
#
# The data can then be loaded with the rake db:examples (or created alongside
# the db with db:nuke_pave).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# creates sample users
%w(Dan Qusai Nick Dennis).each do |name|
  email = "#{name}@#{name}.com"
  next if User.exists? email: email
  User.create!(email: email,
               password: 'abc123',
               password_confirmation: nil)
end

# creates sample games
Game.transaction do
  %w(Splendor Carverna Dominion Takenoko).each do |n|
    name = n
    next if Game.exists? name: name
    Game.create!(name: name)
  end
end

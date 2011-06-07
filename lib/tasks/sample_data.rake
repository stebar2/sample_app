namespace :db do
  desc 'Fill database with sample data'
  
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

# Create 100 users with one admin
def make_users
  # Create admin user
  admin = User.create!(:name => 'Example User',
                       :email => 'example@railstutorial.org',
                       :password => 'foobar',
                       :password_confirmation => 'foobar')
  admin.toggle!(:admin)             
  
  # Create 99 other users
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
    end
end

# Create 50 microposts for each user
def make_microposts
  User.all.each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end

def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
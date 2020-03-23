namespace :create_user do
  desc "this is for creating admin users in development and production environment via command line"
  task :admin, [:email, :password]=> :environment do |t, args|
    raise "Email and Password are required fields" unless args[:email] || args[:password]

    create_user(email: args[:email], password: args[:password] )
  end

  def create_user(*attrs)
    User.create(attrs)
  end
end

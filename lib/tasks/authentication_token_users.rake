namespace :db do
  desc "Adds authentication_token for all users in the db"
  task :create_api_tokens => :environment do
    User.all.each do |u|
      u.send(:generate_authentication_token)
      u.save!
    end
  end

end

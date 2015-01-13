# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  activated         :boolean          default("false")
#  activated_at      :datetime
#  activation_digest :string
#  admin             :boolean          default("false")
#  email             :string
#  name              :string
#  password_digest   :string
#  remember_digest   :string
#  reset_digest      :string
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

FactoryGirl.define do
  factory :user do
    pwd = Faker::Internet.password

    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { pwd }
    password_confirmation { pwd }

    factory :admin do
      admin { true }
    end
  end
end

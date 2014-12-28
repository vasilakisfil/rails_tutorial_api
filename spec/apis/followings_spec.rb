require 'rails_helper'

describe Api::V1::FollowingsController, type: :api do
  context :index do
    before do
      #create_and_sign_in_follower
      @resources_count = 5
      user = FactoryGirl.create(:user)
      followings = FactoryGirl.create_list(:user, 5)
      followings.each { |f| user.follow(f) }

      get api_v1_followings_path, user_id: user.id, format: :json
    end
    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end
    it 'returns the correct number of data in the body' do
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:followings].length).to eql(@resources_count)
    end
  end

=begin
  context :show do
    before do
      #create_and_sign_in_follower
      FactoryGirl.create(:follower)
      @follower = User.last

      get api_v1_follower_path(@follower.id), format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end

    it 'returns the data in the body' do
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:follower][:name]).to eql(@follower.name)
      expect(body[:follower][:updated_at]).to eql(@follower.updated_at.iso8601)
    end
  end

  context :create do
    before do
      #create_and_sign_in_follower
      user = FactoryGirl.create(:user)
      follower = FactoryGirl.create(:user)

      post api_v1_followers_path, {follower: follower.as_json, user_id: user.id}, format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(201)
    end

    it 'returns the data in the body' do
      follower = User.last
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:follower][:name]).to eql(follower.name)
      expect(body[:follower][:updated_at]).to eql(follower.updated_at.iso8601)
    end
  end



  context :update do
    before do
      #create_and_sign_in_follower
      @follower = FactoryGirl.create(:follower)
      @name = 'Another name'
      @follower.name = @name
      put api_v1_follower_path(@follower.id), follower: @follower.as_json, format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end

    it 'returns the correct location' do
      expect(last_response.headers['Location'])
        .to include(api_v1_follower_path(@follower.id))
    end

    it 'returns the data in the body' do
      follower = User.last
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:follower][:name]).to eql(@name)
      expect(body[:follower][:updated_at]).to eql(follower.updated_at.iso8601)
    end
  end

  context :delete do
    context 'when the resource does NOT exist' do
      before do
        #create_and_sign_in_follower
        @follower = FactoryGirl.create(:follower)
        delete api_v1_follower_path(rand(100..1000)), format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(404)
      end
    end

    context 'when the resource does exist' do
      before do
        #create_and_sign_in_follower
        @follower = FactoryGirl.create(:follower)

        delete api_v1_follower_path(@follower.id), format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(204)
      end

      it 'actually deletes the resource' do
        expect(User.find_by(id: @follower.id)).to eql(nil)
      end
    end
  end
=end
end



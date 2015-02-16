require 'rails_helper'

describe Api::V1::UsersController, type: :api do
  context :index do
    before do
      #create_and_sign_in_user
      @resources_count = 5
      5.times{ FactoryGirl.create(:user) }

      get api_v1_users_path, format: :json
    end
    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end
    it 'returns the correct number of data in the body' do
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:users].length).to eql(@resources_count)
    end
  end

  context :create do
    before do
      #create_and_sign_in_user
      user = FactoryGirl.attributes_for(:user)
      post api_v1_users_path, user: user.as_json, format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(201)
    end

    it 'returns the data in the body' do
      user = User.last
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:user][:name]).to eql(user.name)
      expect(body[:user][:updated_at]).to eql(user.updated_at.iso8601)
    end
  end

  context :show do
    before do
      create_and_sign_in_user
      FactoryGirl.create(:user)
      @user = User.last

      get api_v1_user_path(@user.id), format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end

    it 'returns the data in the body' do
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:user][:name]).to eql(@user.name)
      expect(body[:user][:updated_at]).to eql(@user.updated_at.iso8601)
    end
  end


  context :update do
    before do
      create_and_sign_in_user
      @user = FactoryGirl.create(:user)
      @name = 'Another name'
      @user.name = @name
      put api_v1_user_path(@user.id), user: @user.as_json, format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end

    it 'returns the correct location' do
      expect(last_response.headers['Location'])
        .to include(api_v1_user_path(@user.id))
    end

    it 'returns the data in the body' do
      user = User.last
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:user][:name]).to eql(@name)
      expect(body[:user][:updated_at]).to eql(user.updated_at.iso8601)
    end
  end

  context :delete do
    context 'when the resource does NOT exist' do
      before do
        create_and_sign_in_user
        @user = FactoryGirl.create(:user)
        delete api_v1_user_path(rand(100..1000)), format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(404)
      end
    end

    context 'when the resource does exist' do
      before do
        create_and_sign_in_user
        @user = FactoryGirl.create(:user)

        delete api_v1_user_path(@user.id), format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(204)
      end

      it 'actually deletes the resource' do
        expect(User.find_by(id: @user.id)).to eql(nil)
      end
    end
  end
end

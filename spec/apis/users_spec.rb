require 'rails_helper'

describe Api::V1::UsersController, type: :api do
  context :index do
    before do
      5.times{ FactoryGirl.create(:user) }

      get api_v1_users_path, format: :json
    end

    it_returns_status(200)

    it_returns_resources(root: 'users', number: 5)
  end

  context :create do
    before do
      #create_and_sign_in_user
      @user = FactoryGirl.attributes_for(:user)
      post api_v1_users_path, user: @user.as_json, format: :json
    end

    it_returns_status(201)

    it_returns_attributes(resource: 'user', model: '@user', only: [
      :email, :name
    ])

    it_returns_more_attributes(
      resource: 'user',
      model: 'User.last!',
      only: [:updated_at, :created_at],
      modifier: 'iso8601'
    )
  end

  context :show do
    before do
      create_and_sign_in_user
      FactoryGirl.create(:user)
      @user = User.last!

      get api_v1_user_path(@user.id), format: :json
    end

    it_returns_status(200)

    it_returns_attributes(resource: 'user', model: '@user', only: [
      :email, :name, :admin, :activated, :id
    ])

    it_returns_more_attributes(
      resource: 'user',
      model: '@user',
      only: [:updated_at, :created_at],
      modifier: 'iso8601'
    )
  end


  context :update do
    before do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      @name = 'Another name'
      @user.name = @name
      put api_v1_user_path(@user.id), user: @user.as_json, format: :json
    end

    it_returns_status(200)

    it_returns_attributes(resource: 'user', model: '@user', only: [
      :email, :name, :admin, :activated, :id
    ])

    it_returns_more_attributes(
      resource: 'user',
      model: '@user',
      only: [:updated_at, :created_at],
      modifier: 'iso8601'
    )

    it_includes_in_headers({Location: 'api_v1_user_path(@user.id)'})
  end

  context :delete do
    context 'when the resource does NOT exist' do
      before do
        @user = create_and_sign_in_user

        delete api_v1_user_path(rand(100..1000)), format: :json
      end

      it_returns_status(404)
    end

    context 'when the resource does exist' do
      before do
        @user = create_and_sign_in_user

        delete api_v1_user_path(@user.id), format: :json
      end

      it_returns_status(204)

      it 'actually deletes the resource' do
        expect(User.find_by(id: @user.id)).to eql(nil)
      end
    end
  end
end

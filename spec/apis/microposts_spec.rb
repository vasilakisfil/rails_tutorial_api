require 'rails_helper'

describe Api::V1::MicropostsController, type: :api do
  context :index do
    before do
      user = create_and_sign_in_user
      5.times{ FactoryGirl.create(:micropost, user: user) }

      get api_v1_microposts_path, user_id: user.id, format: :json
    end

    it_returns_status(200)

    it_returns_resources(root: 'microposts', number: 5)
  end

  context :create do
    before do
      @user = create_and_sign_in_user
      @micropost = FactoryGirl.attributes_for(:micropost).merge(user_id: @user.id)

      post api_v1_microposts_path, micropost: @micropost.as_json, format: :json
    end

    it_returns_status(201)

    it_returns_attributes(resource: 'micropost', model: '@micropost', only: [
      :content, :user_id
    ])

    it_returns_more_attributes(
      resource: 'micropost',
      model: 'Micropost.last!',
      only: [:updated_at, :created_at],
      modifier: 'iso8601'
    )
  end

  context :show do
    before do
      create_and_sign_in_user
      @micropost = FactoryGirl.create(:micropost)

      get api_v1_micropost_path(@micropost.id), format: :json
    end

    it_returns_status(200)

    it_returns_attributes(resource: 'micropost', model: '@micropost', only: [
      :content, :user_id
    ])

    it_returns_more_attributes(
      resource: 'micropost',
      model: 'Micropost.last!',
      only: [:updated_at, :created_at],
      modifier: 'iso8601'
    )
  end

  context :update do
    context "without ownership" do
      before do
        create_and_sign_in_user
        @micropost = FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
        @micropost.content = 'Another content'

        put api_v1_micropost_path(@micropost.id), micropost: @micropost.as_json, format: :json
      end

      it_returns_status(403)
    end

    context "wih ownership" do
      before do
        user = create_and_sign_in_user
        @micropost = FactoryGirl.create(:micropost, user: user)
        @micropost.content = 'Another content'

        put api_v1_micropost_path(@micropost.id), micropost: @micropost.as_json, format: :json
      end

      it_returns_status(200)

      it_includes_in_headers({Location: 'api_v1_micropost_path(@micropost.id)'})

      it_returns_attributes(resource: 'micropost', model: '@micropost', only: [
        :content, :user_id
      ])

      it_returns_more_attributes(
        resource: 'micropost',
        model: 'Micropost.last!',
        only: [:updated_at, :created_at],
        modifier: 'iso8601'
      )
    end
  end

  context :delete do
    context 'when the resource does NOT exist' do
      before do
        create_and_sign_in_user
        @micropost = FactoryGirl.create(:micropost)
        delete api_v1_micropost_path(rand(100..1000)), format: :json
      end

      it_returns_status(404)
    end

    context 'when the resource does exist' do
      before do
        user = create_and_sign_in_user
        @micropost = FactoryGirl.create(:micropost, user: user)

        delete api_v1_micropost_path(@micropost.id), format: :json
      end

      it_returns_status(204)

      it 'actually deletes the resource' do
        expect(Micropost.find_by(id: @micropost.id)).to eql(nil)
      end
    end
  end
end


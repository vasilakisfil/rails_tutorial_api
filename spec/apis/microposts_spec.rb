require 'rails_helper'

describe Api::V1::MicropostsController, type: :api do
  context :index do
    before do
      #create_and_sign_in_micropost
      5.times{ FactoryGirl.create(:micropost) }

      get api_v1_microposts_path, format: :json
    end
    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end
    it 'returns the correct number of data in the body' do
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:microposts].length).to eql(5)
    end
  end

  context :create do
    before do
      #create_and_sign_in_micropost
      @user = FactoryGirl.create(:user)
      micropost = FactoryGirl.attributes_for(:micropost).merge(user_id: @user.id)

      post api_v1_microposts_path, micropost: micropost.as_json, format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(201)
    end

    it 'returns the data in the body' do
      micropost = Micropost.last!
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:micropost][:content]).to eql(micropost.content)
      expect(body[:micropost][:updated_at]).to eql(micropost.updated_at.iso8601)
      expect(body[:micropost][:user_id]).to eql(@user.id)
    end
  end

  context :show do
    before do
      #create_and_sign_in_micropost
      @micropost = FactoryGirl.create(:micropost)

      get api_v1_micropost_path(@micropost.id), format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end

    it 'returns the data in the body' do
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:micropost][:content]).to eql(@micropost.content)
      expect(body[:micropost][:updated_at]).to eql(@micropost.updated_at.iso8601)
    end
  end

  context :update do
    before do
      #create_and_sign_in_micropost
      @micropost = FactoryGirl.create(:micropost)
      @micropost.content = 'Another content'

      put api_v1_micropost_path(@micropost.id), micropost: @micropost.as_json, format: :json
    end

    it 'returns the correct status' do
      expect(last_response.status).to eql(200)
    end

    it 'returns the correct location' do
      expect(last_response.headers['Location'])
        .to include(api_v1_micropost_path(@micropost.id))
    end

    it 'returns the data in the body' do
      micropost = Micropost.last!
      body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
      expect(body[:micropost][:content]).to eql(@micropost.content)
      expect(body[:micropost][:updated_at]).to eql(micropost.updated_at.iso8601)
    end
  end

  context :delete do
    context 'when the resource does NOT exist' do
      before do
        #create_and_sign_in_micropost
        @micropost = FactoryGirl.create(:micropost)
        delete api_v1_micropost_path(rand(100..1000)), format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(404)
      end
    end

    context 'when the resource does exist' do
      before do
        #create_and_sign_in_micropost
        @micropost = FactoryGirl.create(:micropost)

        delete api_v1_micropost_path(@micropost.id), format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(204)
      end

      it 'actually deletes the resource' do
        expect(Micropost.find_by(id: @micropost.id)).to eql(nil)
      end
    end
  end
end


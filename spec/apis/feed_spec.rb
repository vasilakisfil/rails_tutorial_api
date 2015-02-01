require 'rails_helper'

describe Api::V1::FeedController, type: :api do
  context :index do
    before do
      @user = FactoryGirl.create(:user)
      5.times{ FactoryGirl.create(:micropost, user: @user) }
    end

    context 'without user_id' do
      before do
        get api_v1_feed_index_path, format: :json
      end

      it 'returns 422 error' do
        expect(last_response.status).to eql(422)
      end
    end

    context 'with user_id' do
      before do
        get api_v1_feed_index_path, user_id: @user.id, format: :json
      end

      it 'returns the correct status' do
        expect(last_response.status).to eql(200)
      end

      it 'returns the correct number of data in the body' do
        body = HashWithIndifferentAccess.new(MultiJson.load(last_response.body))
        expect(body[:feeds].length).to eql(5)
      end
    end
  end
end


require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it { should route(:post, 'api/user').to(action: :create) }

  describe '#create.json' do
    let(:params) do
      {
        name: 'Test name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      }
    end

    let(:user) { stub_model User }

    before { expect(User).to receive(:new).with(params).and_return(user) }

    before { expect(user).to receive(:save!) }

    before { post :create, user: params, format: :json }

    it { should render_template :create }
  end
end

require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#as_json' do
    let(:user) { stub_model User, name: 'Test name', email: 'test@test.com' }

    subject { user.decorate.as_json }

    its([:name]) { should eq 'Test name' }

    its([:email]) { should eq 'test@test.com' }
  end
end
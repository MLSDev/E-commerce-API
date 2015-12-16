require 'rails_helper'

RSpec.describe Session, type: :lib do
  it { should be_a ActiveModel::Validations }

  let(:session) { Session.new email: 'test@test.com', password: '12345678' }

  let(:user) { stub_model User }

  subject { session }

  its(:email) { should eq 'test@test.com' }

  its(:password) { should eq '12345678' }

  its(:decorate) { should eq subject }

  describe '#user' do
    before { expect(User).to receive(:find_by).with(email: 'test@test.com') }

    it { expect { subject.send :user }.to_not raise_error }
  end

  context 'validations' do
    subject { session.errors }

    context do
      before { expect(session).to receive(:user) }

      before { session.valid? }

      its([:email]) { should eq ['not found'] }
    end

    context do
      before { expect(session).to receive(:user).twice.and_return(user) }

      before { expect(user).to receive(:authenticate).with('12345678').and_return(false) }

      before { session.valid? }

      its([:password]) { should eq ['is invalid'] }
    end
  end

  describe '#save!' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      it { expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed) }
    end

    context do
      before { expect(subject).to receive(:user).and_return(user) }

      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(SecureRandom).to receive(:uuid).and_return('XXXX-YYYY-ZZZZ') }

      before { expect(user).to receive(:create_auth_token).with(value: 'XXXX-YYYY-ZZZZ') }

      it { expect { subject.save! }.to_not raise_error }
    end
  end

  describe '#destroy!' do
    before do
      #
      # subject.user.auth_token.destroy!
      #
      expect(subject).to receive(:user) do
        double.tap do |a|
          expect(a).to receive(:auth_token) do
            double.tap do |b|
              expect(b).to receive(:destroy!)
            end
          end
        end
      end
    end

    it { expect { subject.destroy! }.to_not raise_error }
  end

  describe '#auth_token' do
    context do
      before { expect(subject).to receive(:user) }

      its(:auth_token) { should eq nil }
    end

    context do
      let(:auth_token) { stub_model AuthToken, value: 'XXXX-YYYY-ZZZZ' }

      let(:user) { stub_model User, auth_token: auth_token }

      before { expect(subject).to receive(:user).and_return(user) }

      its(:auth_token) { should eq 'XXXX-YYYY-ZZZZ' }
    end
  end

  describe '#as_json' do
    before { expect(subject).to receive(:auth_token).and_return('XXXX-YYYY-ZZZZ') }

    its(:as_json) { should eq auth_token: 'XXXX-YYYY-ZZZZ' }
  end
end
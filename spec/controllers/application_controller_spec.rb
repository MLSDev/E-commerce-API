require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#authenticate' do
    before { expect(subject).to receive(:authenticate_or_request_with_http_token).and_yield('token', nil) }

    before do
      #
      # User.joins(:auth_token).find_by(auth_tokens: { value: 'token' })
      #
      expect(User).to receive(:joins).with(:auth_token) do
        double.tap do |a|
          expect(a).to receive(:find_by).with(auth_tokens: { value: 'token' })
        end
      end
    end

    it { expect { subject.send :authenticate }.to_not raise_error }
  end

  describe '#json_request?' do
    before do
      #
      # subject.request.format.json? -> true
      #
      expect(subject).to receive(:request) do
        double.tap do |a|
          expect(a).to receive(:format) do
            double.tap do |b|
              expect(b).to receive(:json?).and_return(true)
            end
          end
        end
      end
    end

    its(:json_request?) { should eq true }
  end
end
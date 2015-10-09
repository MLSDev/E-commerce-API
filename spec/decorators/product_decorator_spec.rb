require 'rails_helper'

describe ProductDecorator do
  describe '#as_json' do
    let(:product) { stub_model Product, id: 1, name: 'apple', price: 10.0, description: 'green' }

    subject { product.decorate.as_json }

    its([:id]) { should eq 1 }

    its([:name]) { should eq 'apple' }

    its([:price]) { should eq 10.0 }

    its([:description]) { should eq 'green' }
  end
end
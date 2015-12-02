require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should be_a PgSearch }

  describe '.search_by' do
    let(:relation) { double }

    before { expect(Product).to receive(:page).with(1).and_return(relation) }

    context do
      it { expect { Product.search_by 'page' => 1 }.to_not raise_error }
    end

    context do
      before { expect(relation).to receive(:where).with('name ILIKE ?', 'abc%') }

      it { expect { Product.search_by 'page' => 1, 'term' => 'abc' }.to_not raise_error }
    end

    context do
      before { expect(relation).to receive(:search).with('word') }

      it { expect { Product.search_by 'page' => 1, 'name' => 'word' }.to_not raise_error }
    end
  end
end
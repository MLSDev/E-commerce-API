require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  it { should route(:get, '/api/products').to(action: :index) }

  it { should route(:get, '/api/products/1').to(action: :show, id: 1) }

  describe '#index.json' do
    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe '#show.json' do
    before { get :show, id: 1, format: :json }

    it { should render_template :show }
  end
end

require 'rails_helper'

RSpec.describe "pages/error.html.erb", type: :view do
  it 'tells user to contact support if needed' do
    render
    expect(rendered).to match /Please contact support if you need help/
  end
end

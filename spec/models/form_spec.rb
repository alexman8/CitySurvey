require 'rails_helper'

RSpec.describe Form, type: :model do
  it 'should have many form fields' do
    t = Form.reflect_on_association(:form_fields)
    expect(t.macro).to eq :has_many
  end

  it 'should have many form submissions' do
    t = Form.reflect_on_association(:form_submissions)
    expect(t.macro).to eq :has_many
  end

  it 'is not valid with a blank title' do
    form = build(:form, title: ' ')
    expect(form).to_not be_valid
  end

  it 'is not valid with a description with a length larger than 100' do
    form = build(:form, description: 'a' * 101)
    expect(form).to_not be_valid
  end

  context 'if it has no form field' do
    it 'is not valid' do
      form = build(:form)
      expect(form).to_not be_valid
    end
  end

  context 'if it has at least one form field' do
    it 'is valid' do
      form_with_field = build(:form_with_field)
      expect(form_with_field).to be_valid
    end
  end
end

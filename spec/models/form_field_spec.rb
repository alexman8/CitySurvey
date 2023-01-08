require 'rails_helper'

RSpec.describe FormField, type: :model do
  it 'should belong to a form' do
    t = FormField.reflect_on_association(:form)
    expect(t.macro).to eq :belongs_to
  end

  it 'should have many form entries' do
    t = FormField.reflect_on_association(:form_entries)
    expect(t.macro).to eq :has_many
  end

  it 'should have many form field options' do
    t = FormField.reflect_on_association(:form_field_options)
    expect(t.macro).to eq :has_many
  end

  it 'is not valid with a blank name' do
    form_field = build(:form_field, name: ' ')
    expect(form_field).to_not be_valid
  end

  it 'is not valid with a name with a length larger than 50' do
    form_field = build(:form_field, name: 'a' * 51)
    expect(form_field).to_not be_valid
  end

  it 'is not valid with a description with a length larger than 100' do
    form_field = build(:form_field, description: 'a' * 101)
    expect(form_field).to_not be_valid
  end

  describe 'has_options?' do
    context 'if it is a field of radio type' do
      it 'should return true' do
        form_field_radio = build(:form_field_radio)
        expect(form_field_radio.has_options?).to eq true
      end
    end

    context 'if it is a field of text type' do
      it 'should return false' do
        form_field_text = build(:form_field_text)
        expect(form_field_text.has_options?).to eq false
      end
    end
  end
end

require 'rails_helper'

RSpec.describe FormFieldOption, type: :model do
  it 'should belong to a form field' do
    t = FormFieldOption.reflect_on_association(:form_field)
    expect(t.macro).to eq :belongs_to
  end

  it 'is invalid with a duplicate form field and value' do
    form              = create(:form_with_field)
    form_field        = form.form_fields.first
    form_field_option = create(:form_field_option, form_field: form_field)

    form_field_option_duplicate = build(:form_field_option,
                                        form_field: form_field_option.form_field,
                                        value:      form_field_option.value)

    expect(form_field_option_duplicate).not_to be_valid
  end

  it 'is invalid with a blank value' do
    form_field_option = build(:form_field_option, value: ' ')
    expect(form_field_option).to_not be_valid
  end

  it 'is invalid with a value with a length greater than 50' do
    form_field_option = build(:form_field_option, value: 'a' * 51)
    expect(form_field_option).to_not be_valid
  end
end

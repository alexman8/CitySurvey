require 'rails_helper'

RSpec.describe FormEntry, type: :model do
  it 'should belongs to a form submission' do
    t = FormEntry.reflect_on_association(:form_submission)
    expect(t.macro).to eq :belongs_to
  end

  it 'should belongs to a form field' do
    t = FormEntry.reflect_on_association(:form_field)
    expect(t.macro).to eq :belongs_to
  end

  it 'is not valid with a duplicate form submission and form field' do
    form_entry           = create(:form_entry)
    form_entry_duplicate = build(:form_entry,
                                 form_submission: form_entry.form_submission,
                                 form_field:      form_entry.form_field)
    expect(form_entry_duplicate).to_not be_valid
  end

  it 'is not valid with a value of length larger than 100' do
    form_entry = build(:form_entry, value: 'a' * 101)
    expect(form_entry).to_not be_valid
  end

  it 'is not valid with a blank value if the form field is required' do
    form_entry_blank_required = build(:form_entry_required, value: ' ')
    expect(form_entry_blank_required).to_not be_valid
  end
end

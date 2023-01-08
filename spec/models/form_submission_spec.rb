require 'rails_helper'

RSpec.describe FormSubmission, type: :model do
  it 'is valid with a form' do
    form_submission = create(:form_submission)
    expect(form_submission).to be_valid
  end
end

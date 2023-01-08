FactoryBot.define do
  factory :form_entry do
    form_submission
    value { 'Some value' }

    factory :form_entry_required do
      form_submission factory: :form_submission_with_required_field
    end

    # Cannot simply use the "form_field" factory for the association because that may
    # create duplicate form fields with the same form_id and name which violate the
    # database unique constraint
    after(:build) do |form_entry|
      form_entry.form_field = form_entry.form_submission.form.form_fields.first
    end
  end
end

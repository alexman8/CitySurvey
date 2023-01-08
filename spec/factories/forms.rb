FactoryBot.define do
  # For create(), use the factory :form_with_field since a form needs at least one field to be created
  factory :form do
    title { 'Survey' }
    description { 'This is a survey' }

    factory :form_with_field do
      # Can't use the after(:create) callback because the validation of at least one form
      # field is called before the form is created
      #
      # Also can't use
      #
      # form_fields { [association(:form_field)] }"
      # form_fields { create_list(:form_field, 1) }
      #
      # since they try to create the form field before the form exists, and form fields
      # need form_id to save
      #
      # Note that this one-liner below also works:
      # form_fields { build_list(:form_field, 1) }
      #
      after(:build) do |form|
        form.form_fields << build(:form_field, form: form)
      end
    end

    factory :form_with_required_field do
      after(:build) do |form|
        form.form_fields << build(:form_field_required, form: form)
      end
    end
  end
end

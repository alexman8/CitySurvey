FactoryBot.define do
  factory :form_submission do
    form factory: :form_with_field

    factory :form_submission_with_required_field do
      form factory: :form_with_required_field
    end
  end
end

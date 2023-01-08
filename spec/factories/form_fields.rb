FactoryBot.define do
  # Note that when using create() on this factory, you must specify the form manually
  factory :form_field do
    name { 'First name' }
    description { 'E.g. John' }

    factory :form_field_text do
      type { :text }
    end

    factory :form_field_radio do
      type { :radio }
    end

    factory :form_field_required do
      required { true }
    end
  end
end

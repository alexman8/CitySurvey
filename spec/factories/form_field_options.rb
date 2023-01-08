FactoryBot.define do
  # Note that when using create() on this factory, you must specify the form_field manually
  factory :form_field_option do
    value { 'Some option' }
  end
end

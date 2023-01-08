class FormFieldOption < ApplicationRecord
  belongs_to :form_field

  validates :value,
            presence:   true,
            length:     { maximum: 50 },
            uniqueness: { scope: :form_field_id, case_sensitive: false }
end

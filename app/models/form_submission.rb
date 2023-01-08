class FormSubmission < ApplicationRecord
  belongs_to :form
  has_many :form_entries

  accepts_nested_attributes_for :form_entries,
                                reject_if: proc { |attributes| attributes['form_field_id'].blank? }
end

class FormEntry < ApplicationRecord
  belongs_to :form_submission
  belongs_to :form_field

  validates_uniqueness_of :form_submission_id, scope: :form_field_id
  validates :value, length: { maximum: 100 }
  validate :value_must_be_present_if_required

  before_validation :concatenate_value_if_array

  private

  def value_must_be_present_if_required
    return true unless form_field.required
    errors[:value] << 'must be present' if value.blank?
  end

  def concatenate_value_if_array
    if value_is_array_string?
      value_array = JSON[value]
      self.value = value_array.reject(&:blank?).join(', ')
    end
  rescue JSON::ParserError => pe
    logger.error("The value '#{value}' seems to be an array but it is not")
    # No need to re-raise parse error as we just use the original value in this case
  end

  # E.g. ["[\"\"", " \"French fries\"]"]
  def value_is_array_string?
    value.start_with?('[') && value.end_with?(']')
  end
end

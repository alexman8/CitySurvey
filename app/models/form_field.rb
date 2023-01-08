class FormField < ApplicationRecord
  belongs_to :form
  has_many :form_entries
  has_many :form_field_options

  accepts_nested_attributes_for :form_field_options,
                                allow_destroy: true,
                                reject_if:     :reject_form_field_options?

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :form_id, case_sensitive: false }
  validates :description, length: { maximum: 100 }

  self.inheritance_column = nil # For using the column "type" without Rails STI interfering
  enum type: [:text, :textarea, :radio, :checkbox, :drop_down]

  def no_option?
    !has_options?
  end

  def has_options?
    radio? || checkbox? || drop_down?
  end

  private

  def reject_form_field_options?(attributes)
    return false unless no_option? || attributes['value'].blank?
    return true unless attributes[:id].present?
    attributes.merge!(_destroy: 1) # If form field option already exists, should destroy it instead of reject
    false
  end
end

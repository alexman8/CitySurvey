class Form < ApplicationRecord
  has_many :form_fields do
    def persisted
      select { |form_field| form_field.persisted? }
    end

    def new_record
      select { |form_field| form_field.new_record? }
    end
  end
  has_many :form_submissions

  accepts_nested_attributes_for :form_fields, allow_destroy: true

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 100 }
  validate :must_have_at_least_one_form_field

  enum status: [:in_progress, :published]

  has_secure_token

  def build_minimum_form_field
    return if form_fields.any?
    form_field = form_fields.build
    form_field.form_field_options.build
  end

  def build_form_submission
    form_submissions.build.tap do |form_submission|
      form_fields.order(created_at: :asc).each do |form_field|
        form_submission.form_entries.build(form_field: form_field)
      end
    end
  end

  private

  def must_have_at_least_one_form_field
    # Shouldn't count the form fields that are already marked for destruction
    num_of_non_destruct_fields = form_fields.reject(&:marked_for_destruction?).size
    unless num_of_non_destruct_fields > 0
      errors[:base] << 'A form must have at least one form field'
    end
  end
end

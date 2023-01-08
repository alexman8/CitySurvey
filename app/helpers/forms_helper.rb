module FormsHelper
  def edit_form_link(form)
    return nil if form.published?
    link_to 'Edit', edit_form_path(form)
  end

  def publish_form_link(form)
    return nil unless form.in_progress?
    link_to 'Publish', publish_form_path(form),
            method: :patch,
            data:   { confirm: t('activerecord.confirmation.form.publish') }
  end

  def view_form_submissions_link(form)
    form_submissions_count = form.form_submissions.count
    return nil unless form.published? && form_submissions_count > 0
    link_to "View submissions (#{form_submissions_count})", form_form_submissions_path(form)
  end

  def form_entry_value_input(form_entry, form_entry_fields)
    input_hash = { label: false, as: form_field_type_2_sf_type(form_entry.form_field) }
    input_hash.merge!(
      if form_entry.form_field.has_options?
        { collection:    form_entry.form_field.form_field_options.pluck(:value),
          include_blank: !form_entry.form_field.required }
      else
        { input_html: { size: 50, rows: 7, cols: 50 } }
      end
    )

    form_entry_fields.input :value, input_hash
  end

  # Map the form field types to simple_form input types
  def form_field_type_2_sf_type(form_field)
    case
      when form_field.text?
        :string
      when form_field.textarea?
        :text
      when form_field.radio?
        :radio_buttons
      when form_field.checkbox?
        :check_boxes
      when form_field.drop_down?
        :select
    end
  end
end

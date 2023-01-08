class FormFieldDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  TYPE_USER_FRIENDLY_H = { 'text'     => 'Short text',
                           'textarea' => 'Paragraph',
                           'radio'    => 'Select one choice',
                           'checkbox' => 'Mutiple choices' }

  def self.type_collection
    FormField.types.keys.map do |s|
      [TYPE_USER_FRIENDLY_H[s] || s.humanize, s]
    end
  end

  # Show asterisk after a field name if it is required
  def name_required
    name_required = required ? "#{name} *" : name
    h.content_tag :p, name_required
  end

  def description_decorated
    return nil unless description.present?
    h.content_tag :p, description, class: 'form_field__description'
  end

  def input_mockup
    has_options? ? select_input_mockup : text_input_mockup
  end

  def text_input_mockup
    if text?
      h.text_field_tag('name', nil, size: 50)
    elsif textarea?
      h.text_area_tag('name', nil, rows: 7, cols: 50)
    end
  end

  def select_input_mockup
    if drop_down?
      h.select_tag('id', h.options_from_collection_for_select(form_field_options, 'value', 'value'),
                   include_blank: !required)
    elsif radio?
      form_field_options.map do |form_field_option|
        option_value_downcased = form_field_option.value.downcase
        h.radio_button_tag('name', option_value_downcased) +
          h.label_tag("name_#{option_value_downcased}", form_field_option.value)
      end.join.html_safe
    elsif checkbox?
      form_field_options.map do |form_field_option|
        option_value_downcased = form_field_option.value.downcase
        h.check_box_tag(option_value_downcased, form_field_option.value) +
          h.label_tag(option_value_downcased, nil)
      end.join.html_safe
    end
  end
end

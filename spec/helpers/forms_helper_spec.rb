require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FormsHelper. For example:
#
# describe FormsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FormsHelper, type: :helper do
  describe 'form_field_type_2_sf_type' do
    context 'if the form_field is of text type' do
      form_field = FormField.new(type: :text)
      it 'should return the appropriate simple_form input type (:string)' do
        expect(helper.form_field_type_2_sf_type(form_field)).to eq :string
      end
    end

    context 'if the form_field is of textarea type' do
      form_field = FormField.new(type: :textarea)
      it 'should return the appropriate simple_form input type (:text)' do
        expect(helper.form_field_type_2_sf_type(form_field)).to eq :text
      end
    end

    context 'if the form_field is of radio type' do
      form_field = FormField.new(type: :radio)
      it 'should return the appropriate simple_form input type (:radio_buttons)' do
        expect(helper.form_field_type_2_sf_type(form_field)).to eq :radio_buttons
      end
    end

    context 'if the form_field is of checkbox type' do
      form_field = FormField.new(type: :checkbox)
      it 'should return the appropriate simple_form input type (:check_boxes)' do
        expect(helper.form_field_type_2_sf_type(form_field)).to eq :check_boxes
      end
    end

    context 'if the form_field is of drop down type' do
      form_field = FormField.new(type: :drop_down)
      it 'should return the appropriate simple_form input type (:select)' do
        expect(helper.form_field_type_2_sf_type(form_field)).to eq :select
      end
    end
  end
end

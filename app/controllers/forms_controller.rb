class FormsController < ApplicationController
  before_action :http_basic_authenticate, except: :view
  before_action :set_form, only: [:show, :edit, :update, :publish, :view, :destroy]

  def index
    @forms = Form.select('forms.*, COUNT(form_submissions.id) AS form_submissions_count')
                 .left_outer_joins(:form_submissions).group('forms.id').order(created_at: :desc)
  end

  def new
    @form = Form.new
    @form.build_minimum_form_field
    @form_fields = @form.form_fields
  end

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to @form, notice: 'Your form was created successfully'
    else
      @form.build_minimum_form_field
      @form_fields = @form.form_fields
      render :new
    end
  end

  def show
    @form_fields = @form.form_fields.includes(:form_field_options)
                        .order(:created_at).decorate
  end

  def edit
    @form_fields = @form.form_fields.order(:created_at)
  end

  def update
    if @form.update(form_params)
      redirect_to @form, notice: 'Your form was updated successfully'
    else
      @form.build_minimum_form_field
      # Do not reload form fields from the db (e.g. @form.form_fields.order(:created_at));
      # otherwise new form field options that have validation error will be wiped out and
      # user won't be able to see their error message
      #
      # Also need to divide the form fields into persisted and new records because the new records
      # don't have created_at yet so it can be sorted on that attribute. And we need to sort the
      # persisted records by created_at to preserve the form fields order
      @form_fields = @form.form_fields.persisted.sort_by(&:created_at) | @form.form_fields.new_record
      render :edit
    end
  end

  def publish
    if @form.published!
      redirect_to @form, notice: 'Your form was published successfully!'
    else
      render :show
    end
  end

  # For other users to view and submit the form
  def view
    unless params[:token] == @form.token
      redirect_to error_url, alert: t('errors.forbidden') and return
    end

    @form_submission = @form.build_form_submission
    @form_entries    = @form_submission.form_entries
  end

  def destroy
    @form.destroy
    redirect_to forms_url, notice: 'Your form was deleted successfully'
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def form_params
    params.require(:form).permit(
      :title,
      :description,
      form_fields_attributes: [:_destroy,
                               :id,
                               :name,
                               :description,
                               :type,
                               :required,
                               form_field_options_attributes: [:_destroy,
                                                               :id,
                                                               :value]]
    )
  end
end

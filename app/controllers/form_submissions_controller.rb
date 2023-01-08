class FormSubmissionsController < ApplicationController
  before_action :http_basic_authenticate, only: :index
  before_action :set_form_submission, only: :show

  def index
    @form = Form.includes(form_submissions: { form_entries: :form_field }).where(id: params[:form_id]).first
  end

  def create
    @form = Form.find(form_submission_params[:form_id])
    unless params[:form_submission][:token] == @form.token
      redirect_to error_url, alert: t('errors.forbidden') and return
    end

    @form_submission = FormSubmission.new(form_submission_params)
    if @form_submission.save
      redirect_to form_submission_url(@form_submission, token: @form.token),
                  notice: 'Thank you for your submission!'
    else
      @form_entries = @form_submission.form_entries
      render 'forms/view'
    end
  end

  def show
    unless params[:token] == @form_submission.form.token
      redirect_to error_url, alert: t('errors.forbidden') and return
    end
  end

  private

  def set_form_submission
    @form_submission = FormSubmission.find(params[:id])
  end

  def form_submission_params
    # Allow both :value and value: [] so that a form entry can take either simple text or array
    # of text values
    params.require(:form_submission).permit(
      :form_id,
      form_entries_attributes: [:id, :form_field_id, :value, value: []]
    )
  end
end

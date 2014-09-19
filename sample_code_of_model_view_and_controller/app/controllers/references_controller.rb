class ReferencesController < ApplicationController
  before_filter :require_user
  before_filter :reference_manager
  def create
    if @references.save
      redirect_to portal_references_path(applicant_id: params[:applicant_id]), notice: "Successfully added"
    else
      render :index
    end
  end
  def update
    @reference = @references.find(params[:id])
    @reference.update_attributes params[:reference]
    redirect_to portal_references_path(applicant_id: params[:applicant_id]), notice: "Successfully update!"
  end
  private 
  def reference_manager
    @references = SampleCode::ReferenceManager.new(current_user.admin? && params[:applicant_id] && User.find(params[:applicant_id]) || current_user, params[:references])
  end
end

class Admin::ReleaseManagementsController < AdminController
  before_filter :release_manager
 
  def create
   if @release_manager.save
     redirect_to [:admin, :release_managements]
   else
     render :new
   end
  end
  
  def update
    @release_management  = ReleaseManagement.find params[:id]
    if @release_management.update_attributes params[:release_management]
     redirect_to [:admin, :release_managements]
    else
      render text: :error
    end
  end

  def destroy
    ReleaseManagement.find(params[:id]).destroy; render :index
  end

  private
  def release_manager
    @release_manager = ReleaseManager.new current_user, params
  end
end

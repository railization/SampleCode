class ReleaseManager
  attr_accessor :params, :current_user
  def initialize(current_user, params={})
    @current_user, @params = current_user, params
  end
  def paginated_users
    users.paginate(page:@params[:page], per_page: 6)
  end
  def users
    @params[:q] ||= {}; User.not_deleted.send(@params[:u_type]).search(@params[:q].try(:merge!, @params[:term] ? { username_or_first_name_or_last_name_cont: params[:term], id_not_in: ReleaseManagement.pluck(:user_id) } :  {} )).result.order("first_name ASC")
  end
  def save
    lambda {  ReleaseManagement.create(@params[:release_management_new_users].reject { |id| ReleaseManagement.find_by_user_id(id).present?  }.map { |id| {user_id: id} }); return true }.call if @params[:release_management_new_users]
  end
  %w(homeowner expert).each do |u_type|
    define_method "release_management_#{u_type}" do
      ReleaseManagement.includes(:user).where(users_conditions[u_type.to_sym])
    end
  end
  def users_conditions
    {expert: "users.company_id IS NOT NULL", homeowner: {users: { company_id: nil} } }
  end
end

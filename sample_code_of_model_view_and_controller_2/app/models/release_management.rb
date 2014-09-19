class ReleaseManagement < ActiveRecord::Base
  belongs_to :user
  has_many :users_release_managements_features, dependent: :destroy
  accepts_nested_attributes_for :users_release_managements_features
  attr_accessible :user_id, :users_release_managements_features_attributes
  def get_uname
   self.user_first_name
  end
  delegate :first_name, to: :user, allow_nil: true, prefix: true
end

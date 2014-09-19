class Reference < ActiveRecord::Base
  belongs_to :member_application
  has_one :rating, as: :rateable, dependent: :destroy
  has_many :media_libraries, as: :fileable, dependent: :destroy
  with_options allow_destroy: true, reject_if: :all_blank do |assoc|
    assoc.accepts_nested_attributes_for :rating
    assoc.accepts_nested_attributes_for :media_libraries
  end
  attr_accessible :answer_1, :answer_2, :answer_3, :answer_4, :email, :status, :media_libraries_attributes,
  :first_name, :last_name, :member_application_id, :phone, :name, :rating_attributes,
  :member_description, :pro, :resend_email, :secret_question
  delegate :contact_name, prefix: true, to: :member_application, allow_nil: true
  delegate :first_name, prefix: true, to: :company, allow_nil: true
  STATUSES = %w( sent received )
  validates :first_name, :last_name, :status, :phone,
    :email, presence: true
  validates :phone, :email, uniqueness: {
    scope: [:member_application_id, :company_id],
    message: 'is in use for another of your references'
  }
  scope :received, where(status: :received)
  scope :sent, where(status: :sent)
  def name
    [first_name, last_name].compact.join(' ')
  end
  def name=(name)
    self.first_name, self.last_name = name.split(' ', 2)
  end
  def name_initials
    [first_name.try(:first).try(:titleize), last_name.try(:first).try(:titleize)].compact.join("")
  end
  def received?
    status.to_sym == :received
  end
  def sent?
    status.to_sym == :sent
  end
  def complete?
    answer_4.present? ||
      (answer_1.present? && answer_2.present? && answer_3.present?)
  end
  def resend_email=(v)
    self.alert_reference
  end
end

class Participant < ActiveRecord::Base
  audited
  belongs_to :profile
  belongs_to :project
  belongs_to :role
  has_many :role_field_values, dependent: :destroy
  has_many :events, dependent: :nullify
  accepts_nested_attributes_for :role_field_values

  validates :profile, :project, :role, presence: true
  validates :role, uniqueness: {scope: [:profile, :project]}
  validate :roles_amount_validator

  enum status: [:npr,:aup,:uvp]

  def roles_amount_validator
    if self.role.present?
      case self.role.name
      when 'Руководитель проекта'
        errors.add(:role_id, "Не может быть больше одного руководителья проекта") if role_count('Руководитель проекта', 1)
      when 'Ведущий ученый'
        errors.add(:role_id, "Не может быть больше одного ведущего ученого") if role_count('Ведущий ученый', 1)
      when 'Курс-лидер'
        errors.add(:role_id, "Не может быть больше одного курс-лидера") if role_count('Курс-лидер', 1)
      when 'Аспирант'
        errors.add(:role_id, "Не может быть больше двух аспирантов") if role_count('Аспирант', 2)
      end
    end
  end

  def role_count(role,amount)
    project=self.project
    return project.participants.where(role_id: self.role).where.not(profile_id: self.profile_id).count>=amount
  end
end

class Research < ActiveRecord::Base
  audited
  belongs_to :project
  has_and_belongs_to_many :science_branches
  has_and_belongs_to_many :activity_directions

  validates :theme, presence: true  
  # validate :validate_project_type

  def validate_project_type
    if self.project.type == 'EduProject'
      errors.add('Неверный тип проекта')
    end
  end

end

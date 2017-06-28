class Project < ActiveRecord::Base
  audited
  has_many :participants
  has_many :profiles, through: :participants
  has_and_belongs_to_many :publications
  has_and_belongs_to_many :science_branches
  has_and_belongs_to_many :activity_directions
  has_many :events

  #финансы проекта
  has_many :expense_periods
  has_many :planned_expenses, through: :expense_periods
  has_many :expense_items, through: :planned_expenses
  has_many :expense_docs, through: :planned_expenses
  has_many :reserve_docs, through: :planned_expenses
  

  #только для исследовательских и комплексных
  has_many :researches
  accepts_nested_attributes_for :researches

  #только для комплексных
  has_many :other_events

  #только для исследовательских
  has_many :courses
  accepts_nested_attributes_for :courses

  #только для комплексных и образовательных
  has_many :edu_programs
  accepts_nested_attributes_for :edu_programs

  validates :title, :from,:to, presence: true
  validates :from,:to, numericality: { greater_than_or_equal_to: 2015 }
  validate :date_validation

  enum status: {
    draft: 0,
    confirming: 1,
    confirmed: 2,
    archived: 3
  }

  # default_scope { order(created_at: :desc) }

  filterrific(
    available_filters: [
      :with_type
    ]
  )

  scope :with_type, -> (types) { where('type in (?)', types) }

  def self.actual
    return self.where('projects.status != ?', 3)
  end

  def date_validation
    if self.to.present? and self.from.present?
      if self[:to] < self[:from]
        errors[:to] << "Дата окончания должна быть после даты начала"
        return false
      else
        return true
      end
    end
  end

  #Показатели результативности  
  def rate1 #см Rate.find(1)
    return self.publications.where('(publications.quartile_scopus != (3) or publications.quartile_wos != (3)) and (publications.indexed_scopus = 1 or publications.indexed_wos = 1)').size
  end

  def rate2
    return self.rate1
  end

  def rate3
    role_ids = Role.where(name: ['Руководитель проекта','Ведущий ученый','Ключевой член коллектива']).pluck(:id)

    # (Сумма всех цитат в следующих статьях:@1.  входят в б.д.  Scopus,   WoS @2.  Автор статьи-НПР@3.Автор статьи-руководитель либо ведущий ученый либо ключевой член@4.Аффилиация с ДВФУ)
    publs = self.publications.where('(publications.indexed_scopus = 1 or publications.indexed_wos = 1) and publications.affiliated_fefu = 1').joins(profiles: :participants).where('participants.role_id in (?) and participants.status = 0', role_ids).distinct
    #/(Сумма всех статей:@ 1.  входят в б.д.Scopus,WoS @2.Автор статьи-НПР@3.Автор статьи-руководитель либо ведущий ученый либо ключевой член@4.Аффилиация с ДВФУ)
    citaitions_sum = publs.to_a.sum(&:total_cits_scopus_wos).to_f

    return citaitions_sum.to_f/(publs.size.to_f.nonzero? || 1)
  end

  def rate4
    role_ids = Role.where(name: ['Руководитель проекта','Ведущий ученый','Ключевой член коллектива']).pluck(:id)

    #(Сумма всех цитат в следующих статьях:@1.  входят в б.д.  Scopus,   WoS @2.  Автор статьи-НПР@3.Автор статьи-руководитель либо ведущий ученый либо ключевой член@3.Аффилиация с ДВФУ)
    publs = self.publications.where('(publications.indexed_scopus = 1 or publications.indexed_wos = 1) and publications.affiliated_fefu = 1').joins(profiles: :participants).where('participants.role_id in (?) and participants.status = 0', role_ids).distinct
    #/(Сумма всех исполнителей,которые соответствуют следующим критериям:@1.НПР@2.Руководитель либо ведущий ученый либо ключевой член)
    citaitions_sum = publs.to_a.sum(&:total_cits_scopus_wos).to_f
    participants_sum = self.participants.where('participants.role_id in (?) and participants.status = 0', role_ids).size

    return citaitions_sum.to_f/(participants_sum.to_f.nonzero? || 1)
  end

  def rate5
    role_ids = Role.where(name: ['Руководитель проекта','Ведущий ученый','Ключевой член коллектива']).pluck(:id)

    #(Сумма всех исполнителей,которые соответствуют след.критериям:@1.НПР@2.Привлеченный с межд.рынка@3.Руководитель либо ведущий ученый либо@ ключевой член)
    international_participants_sum = self.profiles.where('participants.role_id in (?) and participants.status = 0 and (profiles.labour_market = 1 or profiles.academic_degree = 1)', role_ids).size
    #/(Сумма всех исполнителей,которые  соответствуют след.  критериям:@1.НПР@2.Руководитель либо ведущий ученый либо @ключевой член)
    participants_sum = self.participants.where('participants.role_id in (?) and participants.status = 0', role_ids).size

    return (international_participants_sum.to_f/(participants_sum.to_f.nonzero? || 1)*100)
  end

  def rate6 #Количество обучающихся на основных образовательных программах
    return self.edu_programs.map{|e| e.students.size.to_i}.inject(:+).to_i
  end

  def rate7 #Количество иностранных студентов
    rus = Nationality.find_by_name('Россия')
    return self.edu_programs.map{|e| e.students.where('nationality_id != (?)', rus.id).size.to_i}.inject(:+).to_i
  end

  def rate8
    return 'нет данных'
  end
end

class Profile < ActiveRecord::Base
  audited
  belongs_to :user
  has_many :nationalities
  has_and_belongs_to_many :publications, uniq: true, dependent: :restrict_with_error
  has_many :participants, dependent: :restrict_with_error
  has_many :projects, through: :participants
  has_many :events, through: :participants
  has_many :stays
  accepts_nested_attributes_for :publications


  enum science_degree: {
    dr: 0,
    phd: 1,
    candidate: 2
  }
  enum labour_market: {
    ru: 0,
    int: 1
  }
  validates :last_name, :first_name, :latin_name, :birthday, :phone, :email_contact, :labour_market, presence: true
  # validates :education_graduation, inclusion: { :in => 1910..2016 }

  def fio
    [last_name, first_name, middle_name].join(' ').strip
  end

  def fio=(name)
    split = name.split(' ', 3)
    self.last_name = split.first
    self.first_name = split.second
    self.middle_name = split.last
  end

  def self.find_by_fio(fio)
    split = fio.split(' ', 3)
    return Profile.where('last_name = ? and first_name = ? and middle_name = ?',split.first, split.second, split.last)
  end

  def amount_publications(source)
    if source == 'scopus'
      return self.publications.where('indexed_scopus', true).count
    elsif source == 'wos'
      return self.publications.where('indexed_wos', true).count
    else
      return self.publications.where('indexed_rinc', true).count
    end
  end

  def citations(source)
    if source == 'scopus'
      return self.publications.pluck(:citations_scopus).flatten.compact.sum
    elsif source == 'wos'
      return self.publications.pluck(:citations_wos).flatten.compact.sum
    elsif source == 'rinc'
      return self.publications.pluck(:citations_rinc).flatten.compact.sum
    else
      return self.publications.pluck(:citations_scopus_wos).flatten.compact.sum
    end
  end
end
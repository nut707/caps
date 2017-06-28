class Publication < ActiveRecord::Base
  audited
  has_and_belongs_to_many :profiles
  has_and_belongs_to_many :projects
  has_many :external_authors, dependent: :destroy
  validates :title, :year, :title_izdanie, presence: true
  validates :year, :numericality => { :greater_than_or_equal_to => 2012 }
  accepts_nested_attributes_for :profiles, :external_authors

  before_save :check

  enum quartile_scopus: [:Q1_sc,:Q2_sc,:Q3_sc,:Q4_sc]
  enum quartile_wos: [:Q1_wos,:Q2_wos,:Q3_wos,:Q4_wos]

  def author
    return Profile.find(self.author_id)
  end

  def authors
    return self.profiles+self.external_authors
  end

  def coauthors
    return self.profiles.where.not(id: self.author_id)+self.external_authors
  end

  def total_cits_scopus_wos
    return self.citations_scopus.to_i+self.citations_wos.to_i+self.citations_scopus_wos.to_i
  end

  private
    def check
      if self.indexed_rinc == false
        self.citations_rinc = nil
      end
      if self.indexed_scopus == false
        self.citations_scopus = nil
        self.quartile_scopus = nil
        self.citations_scopus_wos = nil
      end
      if self.indexed_wos == false
        self.citations_wos = nil
        self.quartile_wos = nil
        self.citations_scopus_wos = nil
      end
    end

end

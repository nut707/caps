class AddAttributesToProfiles < ActiveRecord::Migration
  def change
    # 1.  Фамилия 
    add_column :profiles, :last_name, :string
    # 2.  Имя
    add_column :profiles, :first_name, :string
    # 3.  Отчество
    add_column :profiles, :middle_name, :string
    # 4.  Фамилия и имя латиницей
    add_column :profiles, :latin_name, :string
    # 5.  Дата рождения
    add_column :profiles, :birthday, :datetime
    # 6.  Текущее место работы 
    add_column :profiles, :place_of_work, :string
    # 7.  Должность
    add_column :profiles, :working_postition, :string
    # 8.  Образование (наименование вуза, год выпуска)
    add_column :profiles, :education_university, :string
    add_column :profiles, :education_graduation, :integer, limit: 4
    add_column :profiles, :academic_degree, :string

    # 1.2 Научная деятельность
    # 1.  Ученая степень (список: -доктор наук, -PhD, -кандидат наук)
    add_column :profiles, :science_degree, :integer
    # 2.  Ученое звание
    add_column :profiles, :academic_title, :string
    # 3.  Научные награды
    add_column :profiles, :academic_awards, :text
    # 4.  Членство в различных российских и зарубежных научных организациях (перечислить)
    add_column :profiles, :academic_membership, :string
    add_column :profiles, :science_degree_year, :integer, limit: 4
    # 5.  Привлечен с _____ рынка труда
    # список: - российский
    # - международный*
    add_column :profiles, :labour_market, :integer

    # 1.3 Наукометрические показатели
    add_column :profiles, :monograph_amount, :integer
    # 6.  Индекс Хирша -  
    # - согласно б/д РИНЦ
    add_column :profiles, :index_hirsch_rinc, :integer
    # - согласно б/д Scopus
    add_column :profiles, :index_hirsch_scopus, :integer
    # - согласно б/д Web of Science
    add_column :profiles, :index_hirsch_wos, :integer

    add_column :profiles, :wos_researcher_id, :string
    add_column :profiles, :scopus_author_id, :string
    
    # 7.  Общее количество публикаций в изданиях, индексируемых в базах:
    #  РИНЦ
    # add_column :profiles, :publications_rinc, :integer #удален
    # #  Scopus
    # add_column :profiles, :publications_scopus, :integer #удален
    # #  Web of Science
    # add_column :profiles, :publications_wos, :integer #удален

    # # 8.  Общее количество цитирований в изданиях, индексируемых/входящих в перечень:
    # #  РИНЦ
    # add_column :profiles, :citations_rinc, :integer #удален
    # #  Scopus
    # add_column :profiles, :citations_scopus, :integer #удален
    # #  Web of Science
    # add_column :profiles, :citations_wos, :integer #удален

    # 1.4 Контактная информация
    # 1.  Контактный телефон
    add_column :profiles, :phone, :string
    add_column :profiles, :email_contact, :string

  end
end

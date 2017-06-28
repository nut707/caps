class AddColumnsToEduProgram < ActiveRecord::Migration
  def change

    #Код специальности, направления подготовки
    add_column :edu_programs, :code, :text
    # Описание образовательной программы
    add_column :edu_programs, :desc, :text
    # Описание целевой аудитории
    add_column :edu_programs, :desc_audience, :text
    # Онлайн курсы
    add_column :edu_programs, :online_courses, :text
  end
end

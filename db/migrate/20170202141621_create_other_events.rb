class CreateOtherEvents < ActiveRecord::Migration
  def change
    create_table :other_events do |t|
      
      t.belongs_to :project
      #Название вида работы/мероприятия
      t.text :name
      # 2.    Стоимость (тыс.руб.)
      t.integer :price
      # 3.    Ожидаемый результат для реализации предлагаемого проекта
      t.text :expected_result_for_project
      # 4.    Ожидаемый результат для реализации проекта консорциума САЕ ЦАТИ в целом 
      t.text :expected_result_for_caps
      # 5.    Описание планируемого мероприятия Текстовое поле 
      t.text :desc
      # 6.    Описание целевой аудитории  Текстовое поле
      t.text :target_audience
      # 7.    Описание существующего задела, связь с научным исследованием  
      t.text :desc_of_zadel
      # 8.    План продвижения  Текстовое поле  
      t.text :promotion_plan
      # 9.    Сравнение с аналогами Текстовое поле  
      t.text :comparison_with_analogues

      t.timestamps null: false
    end
  end
end

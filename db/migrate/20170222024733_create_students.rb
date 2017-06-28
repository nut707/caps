class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      # ФИО
      t.string :fio
      # Образовательная программа
      t.belongs_to :edu_program
      # Год обучения (на текущий момент)
      t.integer :edu_year
      # Год рождения
      t.integer :birthday_year
      # Гражданство 
      t.belongs_to :nationality
      # Суммарные баллы ЕГЭ
      t.integer :ege_mark
      # Форма обучения 
      t.integer :forma

      t.timestamps null: false
    end
  end
end

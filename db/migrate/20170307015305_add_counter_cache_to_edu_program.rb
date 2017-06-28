class AddCounterCacheToEduProgram < ActiveRecord::Migration
  def change
    add_column :edu_programs, :students_count, :integer, :default => 0, :null => false
  end
end

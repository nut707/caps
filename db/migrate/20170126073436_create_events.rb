class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.belongs_to :participant
      t.belongs_to :project
      t.integer :status, default: 0
      t.text :report
      t.datetime :report_date

      t.timestamps null: false
    end
  end
end

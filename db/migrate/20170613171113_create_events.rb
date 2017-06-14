class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string   :name,   null: false, default: ""
      t.date     :date,   null: false
      t.boolean  :repeat, null: false, default: false
      t.integer  :period, null: true, default: ""
      
      t.references :user,  index: true
      
      t.timestamps
    end
  end
end

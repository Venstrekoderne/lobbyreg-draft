class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :picture
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.integer :type
      t.string :name
      t.text :description
      t.string :logo

      t.timestamps
    end
    add_index :organizations, :name, unique: true
  end
end

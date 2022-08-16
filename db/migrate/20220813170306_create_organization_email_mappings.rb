class CreateOrganizationEmailMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_email_mappings do |t|
      t.string :regex
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end

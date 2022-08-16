class CreateAllowedSyncers < ActiveRecord::Migration[7.0]
  def change
    create_table :allowed_syncers do |t|
      t.string :email

      t.timestamps
    end
  end
end

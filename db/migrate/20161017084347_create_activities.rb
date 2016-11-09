class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :target_id
      t.string :target_type
      t.string :target_action
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

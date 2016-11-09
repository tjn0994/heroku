class CreateLearnedWords < ActiveRecord::Migration[5.0]
  def change
    create_table :learned_words do |t|
      t.integer :word_id
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end

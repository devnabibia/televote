class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :name, null: false
      t.references :campaign, foreign_key: true, null: false
      t.timestamps
    end
  end
end

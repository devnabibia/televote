class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :identifier, null: false
      t.integer :vote_errors, null: false, default: 0
      t.timestamps
    end
  end
end

class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title, null: false
      t.belongs_to :speaker, null: false
      t.text :abstract, null: false

      t.timestamps
    end

    add_index :talks, :speaker_id
  end
end

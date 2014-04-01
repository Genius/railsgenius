class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.belongs_to :talk, null: false
      t.belongs_to :created_by, null: false

      t.text :body, null: false
      t.string :referent

      t.timestamps
    end

    add_index :annotations, :talk_id
    add_index :annotations, :created_by_id
  end
end

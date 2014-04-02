class AddCreatedByToTalks < ActiveRecord::Migration
  def up
    add_column :talks, :created_by_id, :integer

    execute <<-SQL
      UPDATE talks set created_by_id = 1
    SQL

    change_column :talks, :created_by_id, :integer, null: false
  end

  def down
    remove_column :talks, :created_by_id
  end
end

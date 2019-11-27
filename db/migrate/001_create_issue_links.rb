class CreateIssueLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :issue_links do |t|
      t.integer :project_id, :null => false
      t.integer :tracker_id, :null => false
      t.integer :child_project_id, :null => false
      t.integer :child_tracker_id, :null => false
      t.string :name
      t.integer :position, :default => 1
    end
    add_index :issue_links, :project_id
    add_index :issue_links, :tracker_id
  end
end

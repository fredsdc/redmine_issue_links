class AddCfsToIssueLinks < ActiveRecord::Migration[4.2]
  def change
    add_column :issue_links, :cfs, :string, :default => ""
  end
end

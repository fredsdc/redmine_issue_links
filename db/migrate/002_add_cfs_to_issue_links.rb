class AddCfsToIssueLinks < ActiveRecord::Migration
  def change
    add_column :issue_links, :cfs, :string, :default => ""
  end
end

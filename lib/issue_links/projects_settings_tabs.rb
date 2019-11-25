# This file is a part of Redmine Issue Link
#
# redmine_issue_links is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_issue_links is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_issue_links.  If not, see <http://www.gnu.org/licenses/>.

module IssueLinks
  module ProjectsSettingsTabs
    def self.apply
      ProjectsController.send :helper, IssueLinks::ProjectsSettingsTabs
    end

    def project_settings_tabs
      tabs = super
      tabs << {
        :name => 'issue_links',
        :action => :issue_links,
        :partial => 'issue_links_settings/form',
        :label => :issue_links} if @project.module_enabled?(:issue_tracking) && @project.trackers.any? && User.current.allowed_to?(:edit_project, @project)
      tabs
    end
  end
end

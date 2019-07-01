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

require_dependency 'projects_helper'

module RedmineIssueLinks
  module ProjectsHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :project_settings_tabs, :issue_links
      end
    end
  end

  module InstanceMethods
    def project_settings_tabs_with_issue_links
      tabs = project_settings_tabs_without_issue_links
      tabs << {
        :name => 'issue_links',
        :action => :issue_links,
        :partial => 'issue_links_settings/form',
        :label => :issue_links} if @project.module_enabled?(:issue_tracking) && @project.trackers.any? && User.current.allowed_to?(:edit_project, @project)
      tabs
    end
  end
end

ProjectsHelper.send(:include, RedmineIssueLinks::ProjectsHelperPatch) unless ProjectsHelper.included_modules.include? RedmineIssueLinks::ProjectsHelperPatch

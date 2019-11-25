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

require_dependency 'issue_links/hooks'

Redmine::Plugin.register :redmine_issue_links do
  name 'Redmine Issue Links plugin'
  author 'Frederico Camara'
  description 'This plugin configure custom links on the issue view to shortcut new subtasks'
  version '0.5.0'
  url 'http://github.com/fredsdc/redmine_issue_links'
end

Rails.configuration.to_prepare do
  IssueLinks::ProjectsSettingsTabs.apply
end

# Rails.application.config.to_prepare do
#   unless ProjectsHelper.include?(RedmineIssueLinks::ProjectsHelperPatch)
#     ProjectsHelper.send(:include, RedmineIssueLinks::ProjectsHelperPatch)
#   end
# end

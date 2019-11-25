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

class IssueLink < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :tracker
  belongs_to :child_project, :class_name => 'Project'
  belongs_to :child_tracker, :class_name => 'Tracker'

  acts_as_positioned

  scope :sorted, lambda { order(:position) }
end

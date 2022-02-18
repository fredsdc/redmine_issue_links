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

class IssueLinksController < ApplicationController
  unloadable

  before_action :find_project

  def issue_links_data
    (render_403; return false) unless User.current.allowed_to?(:edit_project, @project)
    # clean invalid values: invalid name or tracker
    issue_links_data = (JSON.parse params[:issue_links_data]).delete_if{|k,v| v["link_name"].blank? || Tracker.pluck(:id).include?(v["tracker_from"]) || Tracker.pluck(:id).include?(v["tracker_to"])}

    links_ids = IssueLink.where(project: @project).pluck(:id)
    issue_links_data.each do |i,v|
      link_id = links_ids.shift
      cfs = (common_custom_fields(v["tracker_from"], v["tracker_to"], v["project_to"]).map(&:first) &
        v["cfs"].split(",").map(&:to_i)).join(",")
      if link_id.nil?
        IssueLink.create(name: v["link_name"], project_id: @project.id, tracker_id: v["tracker_from"], child_project_id:v["project_to"], child_tracker_id: v["tracker_to"], cfs: cfs)
      else
        IssueLink.update(IssueLink.find(link_id).id, name: v["link_name"], project_id: @project.id, tracker_id: v["tracker_from"], child_project_id:v["project_to"], child_tracker_id: v["tracker_to"], cfs: cfs)
      end
    end
    IssueLink.where(id: links_ids).destroy_all
    flash[:notice] = l(:notice_successful_update)
    redirect_to settings_project_path(@project, :tab => 'issue_links')
  end

  def get_tracker_options
    @child_project = Project.find_by_id(params[:child_project_id])
    @selected_tracker = params[:child_tracker_id]
    @issue_link_index = params[:issue_link_index]
  end

  def edit
    (render_403; return false) unless User.current.allowed_to?(:edit_project, @project)
    @common_custom_fields = common_custom_fields(params[:tracker_from], params[:tracker_to], params[:project_to])
    @selected_common_fields = CustomField.where(id: params[:cfs].split(",")).pluck(:id, :name)
    render :partial => 'edit'
  end

private

  def common_custom_fields(tracker_from, tracker_to, project_to)
    if @project && tracker_from && tracker_to && project_to
      @project.all_issue_custom_fields.pluck(:id, :name) &
        Tracker.find_by_id(tracker_from).custom_fields.pluck(:id, :name) &
        Tracker.find_by_id(tracker_to).custom_fields.pluck(:id, :name) &
        Project.find_by_id(project_to).all_issue_custom_fields.pluck(:id, :name)
    else
      []
    end
  end
end

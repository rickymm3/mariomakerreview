class TopicReportController < ApplicationController

  def new

  end

  def create
  end

  def report
    TopicReport.create(topic_report_params)
    Topic.friendly.find(params[:id]).increment(:reports, 1).save
  end

  def report_ajax
    @topic = Topic.friendly.find(params[:id])
    @topic_report = TopicReport.new(topic_id: @topic.id)
  end

  private


  def topic_report_params
    params.require(:topic_report).permit(:user_comment, :report_reason_id, :topic_id)
  end

end

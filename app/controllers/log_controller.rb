class LogController < ApplicationController
  
  def entry
    params[:tags] ||= []
    params[:keystore] ||= {}
    params[:tags] += ['']
    @result = LogEntry.create!(message: params[:message], tags: params[:tags], keystore: params[:keystore].to_unsafe_h)
    render 'index'
  end

  def index
    params[:tags] ||= ['']
    @result = LogEntry.where(''tags: {'$all' => params[:tags]}).sort(created_at: -1).limit(25)
    render 'index'
  end
end
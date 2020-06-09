class LogController < ApplicationController
  
  def entry
    params[:tags] ||= []
    params[:keystore] ||= {}
    params[:tags] << ['']
    @result = LogEntry.create!(message: params[:message], tags: params[:tags], keystore: params[:keystore].to_unsafe_h)
    render 'index'
  end

  def index
    params[:tags] ||= ['']
    @result = LogEntry.where(tags: {'$in' => params[:tags]})
    render 'index'
  end
end
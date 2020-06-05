class LogController < ApplicationController
  
  def entry
    params[:tags] ||= []
    params[:keystore] ||= {}
    @result = LogEntry.create!(message: params[:message], tags: params[:tags], keystore: params[:keystore].to_unsafe_h)
    render 'index'
  end

  def all
    @data = LogEntry.where(tags: {'$in' => params[:tags]})
    render 'index'
  end
end
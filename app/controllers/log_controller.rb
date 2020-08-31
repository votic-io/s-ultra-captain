class LogController < ApplicationController
  
  def entry
    params[:tags] ||= []
    params[:keystore] ||= {}
    params[:tags] += ['']
    params[:tags] = params[:tags].collect{|e| e.upcase}
    @result = LogEntry.create!(message: params[:message], tags: params[:tags], keystore: params[:keystore].to_unsafe_h)
    render 'index'
  end

  def index
    params[:tags] ||= ['']
    params[:tags] = params[:tags].collect{|e| e.upcase}
    @result = LogEntry.where(tags: {'$all': params[:tags]}).sort(created_at: -1).limit(25)
    render 'index'
  end

  def filters
    params[:tags] ||= ['']
    params[:tags] = params[:tags].collect{|e| e.upcase}
    @result = LogEntry.collection.aggregate([
      {'$match': {bucket: Thread.current[:bucket], tags: {'$all': params[:tags]}}},
      {'$sort': {created_at: -1}},
      {'$project': {tags: 1}},
      {'$limit': 1000},
      {'$unwind': '$tags'},
      {'$match': {tags: {'$ne': ''}}},
      {'$group': {'_id': '$tags', count: {'$sum': 1}}},
      {'$sort': {count: -1}},
      {'$limit': 10}
    ]).collect{|e| {tag: e['_id'], count: e[:count]}}
    render 'index'
  end
end
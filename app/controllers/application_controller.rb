class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery

	before_action :validate_bucket
  	around_action :catch_exceptions

  
  def validate_bucket

    request.env.each do |header|
      if header[0] == header[0].upcase
        puts "#{header[0]} #{header[1].to_s}"
      end
    end

    bucket = params[:bucket]
    
    if !bucket.present?
      puts "missing bucket"
      puts request.env['HTTP_USER_AGENT']
      puts request.remote_ip
      puts request.referrer
      puts params
      raise Exception.new(true), "missing bucket"
    else
      #puts "-----------------------"
      #puts params[:bucket]
      #puts "-----------------------"
      Thread.current[:bucket] = params[:bucket]
      Thread.current[:bucket] = Bucket.unscoped.find_or_create_by(bucket: params[:bucket]).bucket
    end
  end

  def catch_exceptions
    yield
  	rescue => exception
    puts "Caught exception! #{exception}" 
    puts request.referrer
    puts params
    print exception.backtrace.join("\n")

    raise exception
  end

end

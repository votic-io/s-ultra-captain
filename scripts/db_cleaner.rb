l = LogEntry.all.first
LogEntry.where(
:bucket => "FULLJAUS", 
:created_at.lt => Time.now - 3.months
).delete_all

start = Time.now
tc = 0
Thread.current[:bucket] = 'FULLJAUS'
LogEntry.where(created_at: {'$gt': Time.now - 3.months}).sort(created_at: -1).each do |l|
lt = LogEntry.where(tags: {'$all': l[:tags]}, created_at: {'$lt': Time.now - 3.months})
c = lt.count 
if c > 0
tc += c
puts "MORE! #{tc}"
lt.delete_all
end
if (Time.now - start) > 10.minutes
puts "10 MINUTES! #{tc}"
break
end
end




tag = l.tags.first
lt = LogEntry.where(tags: tag, created_at: {'$lt': Time.now - 3.months}).count


#------------------------------------------------------------

good_tags = []
bad_tags = []

LogEntry.where(created_at: {'$gt': Time.now - 3.months}).sort(created_at: -1).limit(1000).each do |l|
bad_tags += l.tags
dif_tags = bad_tags.uniq.select{|e| bad_tags.count(e) > 1}
good_tags += dif_tags
good_tags.uniq!
bad_tags = bad_tags - dif_tags
end


start = Time.now
tc = 0
Thread.current[:bucket] = 'FULLJAUS'
r = rand(83669820)
puts "R #{r}"
LogEntry.where(created_at: {'$gt': Time.now - 3.months}).sort(created_at: -1).skip(r).each do |l|
bad_tags += l.tags
dif_tags = bad_tags.uniq.select{|e| bad_tags.count(e) > 1}
good_tags += dif_tags
good_tags.uniq!
bad_tags = bad_tags - dif_tags
substraction = (l[:tags]-bad_tags)
puts "SUBSTRACTION - #{substraction}"
if substraction.present?
lt = LogEntry.where(tags: {'$all': (l[:tags]-bad_tags)}, created_at: {'$lt': Time.now - 3.months})
puts "AFTERCOUNTER #{l.created_at} - #{r}"
c = lt.count 
if c > 0
tc += c
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
puts "MORE! #{tc} - #{good_tags.length} #{bad_tags.length}"
lt.delete_all
end
end
if (Time.now - start) > 10.minutes
puts "10 MINUTES! #{tc}"
break
end
end

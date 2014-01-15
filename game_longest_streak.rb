require 'date'

###### Config Options ######
min_time    = 8
max_time    = 11
min_commits = 1
max_commits = 3

###### Program ######
curr_time = Time.now

no_of_commits = rand(Range.new(min_commits,max_commits))

no_of_commits.times do |x|
File.open('scratchpad', 'w+') {|f| f.write(curr_time.strftime("%S-#{rand(1000)}-#{x}")) }
system("git commit -a -m 'Update Log'")
end

no_of_commits += 1

log = IO.readlines("log")

log[0] = "Total Commits: #{log.first.gsub('Total Commits: ', '').to_i + no_of_commits}"

sno = log.last.split(',')[0].to_i


if ( (Date.today-Date.strptime(log.last.split(',')[1],' %e/%b/%Y-%l:%M:%S')).to_i != 0 )
log.push "#{sno+1}, #{curr_time.strftime("%e/%b/%Y-%I:%M:%S")}, #{no_of_commits}"
else
nos = log.last.split(',')[2].to_i
log[log.size-1] = "#{sno}, #{curr_time.strftime("%e/%b/%Y-%I:%M:%S")}, #{nos+no_of_commits}"
end

File.open("log", "w+") do |f|
  f.puts(log)
end

system("git commit -a -m 'Update Log'")
system("git push origin master")
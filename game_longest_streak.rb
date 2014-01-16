require 'date'
require 'active_support/core_ext/numeric'

###### Config Options ######
min_time    = 15
max_time    = 18
min_commits = 1
max_commits = 2

###### Program ######
def create_commits(no_of_commits)
  no_of_commits.times do |x|
    File.open("#{$curr_dir}/scratchpad", 'w+') {|f| f.write($curr_time.strftime("%S-#{rand(1000)}-#{x}")) }
    system("cd #{$curr_dir} && git commit -a -m 'Update Log'")
  end
end

def update_log(no_of_commits)
  log = IO.readlines("#{$curr_dir}/log")
  log[0] = "Total Commits: #{log.first.gsub('Total Commits: ', '').to_i + no_of_commits}"
  sno = log.last.split(',')[0].to_i

  if ( (Date.today-Date.strptime(log.last.split(',')[1],' %e/%b/%Y-%l:%M:%S')).to_i != 0 )
    log.push "#{sno+1}, #{$curr_time.strftime("%e/%b/%Y-%I:%M:%S")}, #{no_of_commits}"
  else
    nos = log.last.split(',')[2].to_i
    log[log.size-1] = "#{sno}, #{$curr_time.strftime("%e/%b/%Y-%I:%M:%S")}, #{nos+no_of_commits}"
  end

  File.open("#{$curr_dir}/log", "w+") do |f|
    f.puts(log)
  end
end

def update_cron(gap)
  next_time = $curr_time + gap.hours
  File.open("#{$curr_dir}/cron", "w+") do |f|
    f.puts("#{next_time.strftime("%M %H %d %m")} * bash -c 'source #{File.expand_path('~')}/.rvm/scripts/rvm && /usr/bin/env ruby #{$curr_dir}/#{File.basename(__FILE__)}'\n")
  end
  system("cd #{$curr_dir} && crontab cron")
end

$curr_time = Time.now
$curr_dir = "#{File.expand_path( File.dirname( __FILE__ ))}"

no_of_commits = rand(Range.new(min_commits,max_commits))
create_commits(no_of_commits)
update_cron(rand(Range.new(min_time,max_time)))
update_log(no_of_commits+2)

system("cd #{$curr_dir} && git commit -a -m 'Update Log'")
system("cd #{$curr_dir} && git push origin master")

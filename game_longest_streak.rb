fh = File.open('log', 'w+')
fh.puts "Test"
fh.close

system("git commit -a")
system("git push origin master")
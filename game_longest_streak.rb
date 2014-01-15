fh = File.open('log', 'w+')
fh.puts "Test"
fh.close

system("git commit -a -m='update'")
system("git push origin master")
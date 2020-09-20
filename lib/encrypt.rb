require './lib/enigma'

enigma = Enigma.new
message = ARGV[0]
write_file = ARGV[1]

file = File.open(message, 'r')
cypher = enigma.encrypt(file.read.delete("\n"))

new_file = File.open(write_file, 'w')
new_file.write(cypher)
new_file.close

puts "Created #{write_file} with the key #{cypher[:key]} and the date #{cypher[:date]}"

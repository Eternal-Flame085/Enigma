require './lib/enigma'

enigma = Enigma.new
encrypted_file_loc = ARGV[0]
decrypted_file_loc = ARGV[1]
key = ARGV[2]
date = ARGV[3]

file = File.open(encrypted_file_loc, 'r')
decryption = file.read.delete("\n")
decrypted_message = enigma.decrypt(decryption, key, date)

decrypted = File.open(decrypted_file_loc, 'w')
decrypted.write(decrypted_message[:decryption])
decrypted.close

puts "Created #{decrypted_file_loc} with the key #{key} and date #{date}"

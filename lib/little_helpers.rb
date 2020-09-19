module LittleHelpers
  def generate_key
    '%05d' % rand(5 ** 5)
  end

  def generate_date
    Date.today.strftime("%m%d%y")
  end

  def key_combinations(key)
    collector = []
    key.split("").each_cons(2) {|consecutive| collector << consecutive}
    collector.each_with_index do |keys, index|
      collector[index] = keys[0]+keys[1]
    end
    collector
  end

  def date_offset(date)
    offsets = []
    (date.to_i ** 2).to_s[-4..-1].split("").each do |diget|
      offsets << diget
    end
    offsets
  end

  def encrypter(message, keys, offsets)
    final_string = ""
    key_offset_counter = 0
    message.each_char do |letter|
      if !@alphabet.include?(letter)
        final_string += letter
        next
      end
      shift = keys[key_offset_counter].to_i + offsets[key_offset_counter].to_i
      final_shift = shift_finder(shift, letter, "encrypt")
      final_string += @alphabet[final_shift]
      key_offset_counter += 1
      key_offset_counter = 0 if key_offset_counter == 4
    end
    final_string
  end

  def decrypter(cyphertext, keys, offsets)
    final_string = ""
    key_offset_counter = 0
    cyphertext.each_char do |letter|
      if !@alphabet.include?(letter)
        final_string += letter
        next
      end
      shift = keys[key_offset_counter].to_i + offsets[key_offset_counter].to_i
      final_shift = shift_finder(shift, letter, "decrypt")
      final_string += @alphabet[final_shift]
      key_offset_counter += 1
      key_offset_counter = 0 if key_offset_counter == 4
    end
    final_string
  end

  def shift_finder(shift, letter, shift_type)
    alphabet_tracker = @alphabet.index(letter.downcase)
    if shift_type == "encrypt"
      shift.times do
        alphabet_tracker = alphabet_tracker + 1
        alphabet_tracker = 0 if alphabet_tracker == 27
      end
    elsif shift_type == "decrypt"
      shift.times do
        alphabet_tracker = alphabet_tracker - 1
        alphabet_tracker = 26 if alphabet_tracker == -1
      end
    end
    alphabet_tracker
  end
end

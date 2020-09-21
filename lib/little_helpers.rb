module LittleHelpers
  def generate_key
    '%05d' % rand(5 ** 5)
  end

  def generate_date
    Date.today.strftime("%m%d%y")
  end

  def key_combinations(key)
    keys = []
    key.split("").each_cons(2) do |consecutive_numbers|
      keys << consecutive_numbers[0] + consecutive_numbers[1]
    end
    keys
  end

  def date_offset(date)
    date_squared = (date.to_i ** 2).to_s.split("")
    date_squared.pop(4)
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

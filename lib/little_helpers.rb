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
      alphabet_index = alphabet_index_finder(shift, letter, "encrypt")
      final_string += @alphabet[alphabet_index]
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
      alphabet_index = alphabet_index_finder(shift, letter, "decrypt")
      final_string += @alphabet[alphabet_index]
      key_offset_counter += 1
      key_offset_counter = 0 if key_offset_counter == 4
    end
    final_string
  end

  def alphabet_index_finder(shift, letter, shift_type)
    if shift_type == "encrypt"
      final_index = encrypt_shift(shift, letter)
    elsif shift_type == "decrypt"
      final_index = decrypt_shift(shift, letter)
    end
    final_index
  end

  def encrypt_shift(shift, letter)
    alphabet_index = @alphabet.index(letter.downcase)
    shift.times do
      alphabet_index += 1
      alphabet_index = 0 if alphabet_index == 27
    end
    alphabet_index
  end

  def decrypt_shift(shift, letter)
    alphabet_index = @alphabet.index(letter.downcase)
    shift.times do
      alphabet_index -= 1
      alphabet_index = 26 if alphabet_index == -1
    end
    alphabet_index
  end
end

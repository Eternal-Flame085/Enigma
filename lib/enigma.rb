class Enigma
  attr_reader :alphabet
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key, date)
    keys = key_combinations(key)
    offsets = date_offset(date)
    encryption = ""
    key_offset_counter = 0
    message.each_char do |letter|
      shift = keys[key_offset_counter].to_i + offsets[key_offset_counter].to_i
      alphabet_tracker = @alphabet.index(letter.downcase)
      shift.times do
        alphabet_tracker = alphabet_tracker + 1
        alphabet_tracker = 0 if alphabet_tracker == 27
      end
      encryption += @alphabet[alphabet_tracker]
      key_offset_counter += 1
      key_offset_counter = 0 if key_offset_counter == 4
    end
    require "pry"; binding.pry
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
    (date.to_i ** 2).to_s[-4..-1].split("").each do |diget,|
      offsets << diget
    end
    offsets
  end
end

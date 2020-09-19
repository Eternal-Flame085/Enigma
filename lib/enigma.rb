class Enigma
  attr_reader :alphabet
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(encryption, key, date)
    keys = key_combinations(key)
    offsets = date_offset(date)

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

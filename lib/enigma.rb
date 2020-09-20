require './lib/little_helpers'
require 'date'
class Enigma
  include LittleHelpers
  attr_reader :alphabet
  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key = nil, date = nil)
    key = generate_key if key.nil?
    date = generate_date if date.nil?
    keys = key_combinations(key)
    offsets = date_offset(date)
    encrypted_message = encrypter(message, keys, offsets)
    {encryption: encrypted_message, key:key, date:date}
  end

  def decrypt(cyphertext, key, date = nil)
    date = generate_date if date.nil?
    keys = key_combinations(key)
    offsets = date_offset(date)
    decrypted_message = decrypter(cyphertext, keys, offsets)
    {decryption: decrypted_message, key:key, date:date}
  end
end

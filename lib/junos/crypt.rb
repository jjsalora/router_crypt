class RouterCrypt::JunOS
  class << self
    # Encrypts JunOS $9$ style passwords. This is reimplementation of CPAN
    # Crypt::Juniper (by Kevin Brintnall, <kbrint at rufus.net>)  ''juniper_crypt' function
    #
    # @param [String] the plaintext string
    # @return [String] the encrypted string
    def crypt (plaintext, *opts)
      if opts[0] != nil
        salt=opts[0]
      else
        salt=randc(1)
      end

      rand=randc(EXTRA[salt])

      pos = 0
      prev = salt
      crypt="$9$"
      crypt<<salt
      crypt<<rand

      for p in (plaintext.split(''))
        encode = ENCODE[ pos % ENCODE.length]
        crypt<< gap_encode(p, prev, encode)
        prev = crypt[crypt.size-1]
        pos+=1
      end

      crypt

    end
  end
end

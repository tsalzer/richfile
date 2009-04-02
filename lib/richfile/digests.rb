require 'openssl'

module Richfile

# Digest related functionality.
module Digests

  if OpenSSL::OPENSSL_VERSION_NUMBER > 0x00908000
    # all known digests for OpenSSL > 0.9.8
    DIGESTS = %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1 SHA224 SHA256 SHA384 SHA512)
  else
    # all known digests for OpenSSL up to 0.9.8
    DIGESTS = %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1)
  end
  
  def self.each_digest_symbols(&blk) #:nodoc:
    DIGESTS.each do |digest|
      digest_downcase = digest.downcase
      digest_bang = "#{digest_downcase}!".to_sym
      digest_variable = "@#{digest_downcase}".to_sym
      
      blk.call(digest_bang, digest_variable)
    end
  end

# Digest-related methods and attributes to be included in File objects.  
module InstanceMethods
  # DSS1 message digest.
  attr_reader :dss1
  # caching getter for DSS1 message digest.
  def dss1
    @dss1 = self.class.dss1(path) unless @dss1
    @dss1
  end
  # getter for DSS1 message digest.
  # This getter forces the digest to be reloaded.
  def dss1!
    @dss1 = nil
    dss1
  end
  
  # MD2 message digest.
  attr_reader :md2
  # caching getter for MD2 message digest.
  def md2
    @md2 = self.class.md2(path) unless @md2
    @md2
  end
  # getter for MD2 message digest.
  # This getter forces the digest to be reloaded.
  def md2!
    @md2 = nil
    md2
  end
  
  # MD4 message digest.
  attr_reader :md4
  # caching getter for MD4 message digest.
  def md4
    @md4 = self.class.md4(path) unless @md4
    @md4
  end
  # getter for MD4 message digest.
  # This getter forces the digest to be reloaded.
  def md4!
    @md4 = nil
    md4
  end
  
  # MD5 message digest.
  attr_reader :md5
  # caching getter for MD5 message digest.
  def md5
    @md5 = self.class.md5(path) unless @md5
    @md5
  end
  # getter for MD5 message digest.
  # This getter forces the digest to be reloaded.
  def md5!
    @md5 = nil
    md5
  end
  
  # RIPEMD160 message digest.
  attr_reader :ripemd160
  # caching getter for RIPEMD160 message digest.
  def ripemd160
    @ripemd160 = self.class.ripemd160(path) unless @ripemd160
    @ripemd160
  end
  # getter for RIPEMD160 message digest.
  # This getter forces the digest to be reloaded.
  def ripemd160!
    @ripemd160 = nil
    ripemd160
  end
  
  # SHA message digest.
  attr_reader :sha
  # caching getter for SHA message digest.
  def sha
    @sha = self.class.sha(path) unless @sha
    @sha
  end
  # getter for SHA message digest.
  # This getter forces the digest to be reloaded.
  def sha!
    @sha = nil
    sha
  end
  
  # SHA1 message digest.
  attr_reader :sha1
  # caching getter for SHA1 message digest.
  def sha1
    @sha1 = self.class.sha1(path) unless @sha1
    @sha1
  end
  # getter for SHA1 message digest.
  # This getter forces the digest to be reloaded.
  def sha1!
    @sha1 = nil
    sha1
  end
  
  # SHA224 message digest.
  attr_reader :sha224
  # caching getter for SHA224 message digest.
  def sha224
    @sha224 = self.class.sha224(path) unless @sha224
    @sha224
  end
  # getter for SHA224 message digest.
  # This getter forces the digest to be reloaded.
  def sha224!
    @sha224 = nil
    sha224
  end
  
  # SHA256 message digest.
  attr_reader :sha256
  # caching getter for SHA256 message digest.
  def sha256
    @sha256 = self.class.sha256(path) unless @sha256
    @sha256
  end
  # getter for SHA256 message digest.
  # This getter forces the digest to be reloaded.
  def sha256!
    @sha256 = nil
    sha256
  end
  
  # SHA384 message digest.
  attr_reader :sha384
  # caching getter for SHA384 message digest.
  def sha384
    @sha384 = self.class.sha384(path) unless @sha384
    @sha384
  end
  # getter for SHA384 message digest.
  # This getter forces the digest to be reloaded.
  def sha384!
    @sha384 = nil
    sha384
  end
  
  # SHA512 message digest.
  attr_reader :sha512
  # caching getter for SHA512 message digest.
  def sha512
    @sha512 = self.class.sha512(path) unless @sha512
    @sha512
  end
  # getter for SHA512 message digest.
  # This getter forces the digest to be reloaded.
  def sha512!
    @sha512 = nil
    sha512
  end
  
  # refresh the Richfile added attributes.
  # All the attributes referred once are loaded.
  def refresh_digests!
    Richfile::Digests::each_digest_symbols do |d_bang, d_var|
      send d_bang if (instance_variable_get(d_var))
    end
    self
  end
  # refresh all attributes.
  # All attributes wil be loaded, so all digests will be calculated.
  # You will most probably never need this method.
  def refresh_all_digests!
    Richfile::Digests::each_digest_symbols do |d_bang, d_var|
      send d_bang
    end
    self
  end
end#InstanceMethods

# Digest-related methods to be included into File class.
module ClassMethods
  # compute the DSS1 digest of a file.
  def dss1(path)
    hexdigest('DSS1', path)
  end
  # compute the DSS1 digest of a file.
  # uses digest with 'DSS1' as digest to be used.
  def md2(path)
    hexdigest('MD2', path)
  end
  # compute the MD4 digest of a file.
  # uses digest with 'MD4' as digest to be used.
  def md4(path)
    hexdigest('MD4', path)
  end
  # compute the MD5 digest of a file.
  # uses digest with 'MD5' as digest to be used.
  def md5(path)
    hexdigest('MD5', path)
  end
  # compute the RIPEMD160 digest of a file.
  # uses digest with 'RIPEMD160' as digest to be used.
  def ripemd160(path)
    hexdigest('RIPEMD160', path)
  end
  # compute the SHA digest of a file.
  # uses digest with 'SHA' as digest to be used.
  def sha(path)
    hexdigest('SHA', path)
  end
  # compute the SHA1 digest of a file.
  # uses digest with 'SHA1' as digest to be used.
  def sha1(path)
    hexdigest('SHA1', path)
  end
  # compute the SHA224 digest of a file.
  # uses digest with 'SHA224' as digest to be used.
  def sha224(path)
    hexdigest('SHA224', path)
  end
  # compute the SHA256 digest of a file.
  # uses digest with 'SHA256' as digest to be used.
  def sha256(path)
    hexdigest('SHA256', path)
  end
  # compute the SHA384 digest of a file.
  # uses digest with 'SHA384' as digest to be used.
  def sha384(path)
    hexdigest('SHA384', path)
  end
  # compute the SHA512 digest of a file.
  # uses digest with 'SHA512' as digest to be used.
  def sha512(path)
    hexdigest('SHA512', path)
  end
  
  # compute a digest for a given file.
  # - digest: the OpenSSL digest name
  # - path: the file path
  # - returns: hexdigest of the content of the file at the given path
  def hexdigest(digest, path)
    File.open(path, 'r') do |f|
      d = OpenSSL::Digest.new(digest)
      d << f.read
      d.hexdigest
    end
  end
end#DigestClassmethods

module Base #:nodoc:
  def self.included(mod) #:nodoc:
    mod.extend(Richfile::Digests::ClassMethods)
    mod.class_eval { include(Richfile::Digests::InstanceMethods) }
  end
end#Base

end#Digests

end#Richfile

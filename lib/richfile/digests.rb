require 'openssl'

module Richfile

# Digest-related methods and attributes to be included in File objects.  
module Digests

  if OpenSSL::OPENSSL_VERSION_NUMBER > 0x00908000
    DIGESTS = %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1 SHA224 SHA256 SHA384 SHA512)
  else
    DIGESTS = %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1)
  end
  
  def self.digest_variants(digest)
    digest_downcase = digest.downcase
    digest_symbol = digest_downcase.to_sym
    digest_bang = "#{digest_downcase}!".to_sym
    digest_variable = "@#{digest_downcase}".to_sym
    return digest_downcase, digest_symbol, digest_bang, digest_variable
  end
  
module InstanceMethods
  # define attributes for all the digests in Richfile::DIGEST.
  Richfile::Digests::DIGESTS.each do |digest|
    d_downcase, d_sym, d_bang, d_var = Richfile::Digests.digest_variants(digest)
    
    define_method d_bang do
      instance_variable_set(d_var, nil)
      send d_sym
    end
  end
  
  attr_reader :dss1
  def dss1
    @dss1 = self.class.dss1(path) unless @dss1
    @dss1
  end
  attr_reader :md2
  def md2
    @md2 = self.class.md2(path) unless @md2
    @md2
  end
  attr_reader :md4
  def md4
    @md4 = self.class.md4(path) unless @md4
    @md4
  end
  attr_reader :md5
  def md5
    @md5 = self.class.md5(path) unless @md5
    @md5
  end
  attr_reader :ripemd160
  def ripemd160
    @ripemd160 = self.class.ripemd160(path) unless @ripemd160
    @ripemd160
  end
  attr_reader :sha
  def sha
    @sha = self.class.sha(path) unless @sha
    @sha
  end
  attr_reader :sha1
  def sha1
    @sha1 = self.class.sha1(path) unless @sha1
    @sha1
  end
  attr_reader :sha224
  def sha224
    @sha224 = self.class.sha224(path) unless @sha224
    @sha224
  end
  attr_reader :sha256
  def sha256
    @sha256 = self.class.sha256(path) unless @sha256
    @sha256
  end
  attr_reader :sha384
  def sha384
    @sha384 = self.class.sha384(path) unless @sha384
    @sha384
  end
  attr_reader :sha512
  def sha512
    @sha512 = self.class.sha512(path) unless @sha512
    @sha512
  end
  
  # refresh the Richfile added attributes.
  # All the attributes referred once are loaded.
  def refresh_digests!
    DIGESTS.each do |digest|
      d_downcase, d_sym, d_bang, d_var = Richfile.digest_variants(digest)
      send d_bang if (instance_variable_get(d_var))
    end
    self
  end
  # refresh all attributes.
  # All attributes wil be loaded, so all digests will be calculated.
  # You will most probably never need this method.
  def refresh_all_digests!
    DIGESTS.each do |digest|
      d_downcase, d_sym, d_bang, d_var = Richfile.digest_variants(digest)
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

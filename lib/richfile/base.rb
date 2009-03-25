require 'openssl'

# Extension to File.
module Richfile
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

# Methods to be included in File objects.  
module Base
  # size of the file in bytes.
  attr_reader :size
  
  # define attributes for all the digests in Richfile::DIGEST.
  Richfile::DIGESTS.each do |digest|
    d_downcase, d_sym, d_bang, d_var = Richfile.digest_variants(digest)
    
    # message digest #{digest}
    attr_reader d_sym
    
    define_method d_sym do
      instance_variable_set(d_var, File.open(path, 'r') do |f|
        d = OpenSSL::Digest.new(digest)
        d << f.read
        d.hexdigest
      end) unless instance_variable_get(d_var)
      instance_variable_get(d_var)
    end
    define_method d_bang do
      instance_variable_set(d_var, nil)
      send d_sym
    end
  end
  
  # refresh the Richfile added attributes.
  # All the attributes referred once are loaded.
  def refresh!
    self.size! if @size
    DIGESTS.each do |digest|
      d_downcase, d_sym, d_bang, d_var = Richfile.digest_variants(digest)
      send d_bang if (instance_variable_get(d_var))
    end
    self
  end
  
  # refresh all attributes.
  # All attributes wil be loaded, so all digests will be calculated.
  # You will most probably never need this method.
  def refresh_all!
    self.size!
    DIGESTS.each do |digest|
      d_downcase, d_sym, d_bang, d_var = Richfile.digest_variants(digest)
      send d_bang
    end
    self
  end
  
  # proxies File.exists?.
  # This will always go to the real File.exists?, it will not be cached.
  def exists?
    File.exists?(path)
  end
  
  # size of the file in bytes.
  # see File#size
  def size
    @size = File.size(self.path) unless @size
    @size
  end
  # refresh the size attribute.
  def size!
    @size = nil
    self.size
  end

end#Base

# include the Richfile::Base module into the File class.
def self.install
  File.send :include, Richfile::Base
end

end#Richfile

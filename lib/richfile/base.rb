require 'openssl'

# Extension to File.
module Richfile
  # size of the file in bytes.
  attr_reader :size
  
  #alg = %w(DSS DSS1 MD2 MD4 MD5 MDC2 RIPEMD160 SHA SHA1)
  alg = %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1)
  if OpenSSL::OPENSSL_VERSION_NUMBER > 0x00908000
    alg += %w(SHA224 SHA256 SHA384 SHA512)
  end
  DIGESTS=alg
  DIGESTS.each do |digest|
    cd = digest.downcase
    cds = cd.to_sym
    cdsb = "#{cd}!".to_sym
    cdi = "@#{cd}".to_sym
    
    # message digest
    attr_reader cds
    
    define_method cds do
      instance_variable_set(cdi, File.open(path, 'r') do |f|
        d = OpenSSL::Digest.new(digest)
        d << f.read
        d.hexdigest
      end) unless instance_variable_get(cdi)
      instance_variable_get(cdi)
    end
    define_method cdsb do
      instance_variable_set(cdi, nil)
      send cds
    end
  end
  
  # refresh the Richfile added attributes.
  def refresh!
    self.size! if @size
    DIGESTS.each do |digest|
      cd = digest.downcase
      cdsb = "#{cd}!".to_sym
      cdi = "@#{cd}".to_sym
      
      send cdsb if (instance_variable_get(cdi))
    end
    self
  end
  
  def refresh_all!
    self.size!
    DIGESTS.each do |digest|
      cd = digest.downcase
      cdsb = "#{cd}!".to_sym
      cdi = "@#{cd}".to_sym
      
      send cdsb
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
    
end#Richfile

# Extension to File.
module Richfile
  
# Methods to be included in File objects.  
module Base
  # size of the file in bytes.
  attr_reader :size
  
  # refresh the Richfile added attributes.
  # All the attributes referred once are loaded.
  def refresh!
    self.size! if @size
    refresh_digests! if respond_to?(:refresh_all_digests!)
    self
  end
  
  # refresh all attributes.
  # All attributes wil be loaded, so all digests will be calculated.
  # You will most probably never need this method.
  def refresh_all!
    self.size!
    refresh_all_digests! if respond_to?(:refresh_all_digests!)
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
  File.send :include, Richfile::Digests::Base
  File.send :include, Richfile::Mimetype::Base
end

end#Richfile

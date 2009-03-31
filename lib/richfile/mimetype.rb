#require 'mime/types'

module Richfile

# Mimetype functionality for attributes for File objects.
module Mimetype

module InstanceMethods
  attr_reader :mimetype
  def mimetype
    @mimetype = self.class.mimetype(path) unless @mimetype
    @mimetype
  end
end#InstanceMethods

module ClassMethods
  def mimetype(path)
    Richfile::Mimetype.mimetype_using_file(path).first
  end
end#ClassMethods

  # determinate the MimeType using the file system utility.
  # This is probably only available on Unix-like systems.
  #
  # - path: the full path of the file
  # -returns: the mimetype string
  def self.mimetype_using_file(path)
    mimestring = `file --mime -b "#{path}"`.gsub(/\n/,"")
    mimetype, encoding = /(\w+\/\w+); (.+)/.match(mimestring)[1,2]
    return mimetype, encoding
  end

end#Mimetype
end#Richfile

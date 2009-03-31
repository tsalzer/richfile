#require 'mime/types'

module Richfile

# Mimetype functionality for attributes for File objects.
# Currently, this works only for Unix-like OS, since it uses the file system
# utility.
module Mimetype

# Methods made available for instances.
module InstanceMethods
  # the MIME type.
  attr_reader :mimetype
  # get the MIME type.
  def mimetype
    @mimetype = self.class.mimetype(path) unless @mimetype
    @mimetype
  end
  # re-fetch the MIME type.
  def mimetype!
    @mimetype = nil
    self.mimetype
  end
end#InstanceMethods

# Methods implanted into the File class itself.
module ClassMethods
  # get the MIME type from a file using Richfile::Mimetype.mimetype_using_file.
  def mimetype(path)
    Richfile::Mimetype.mimetype_using_file(path).first
  end
end#ClassMethods

  # determinate the MimeType using the file system utility.
  # This is probably only available on Unix-like systems, but is usually
  # quite reliable.
  #
  # - path: the full path of the file
  # - returns: the mimetype string
  def self.mimetype_using_file(path)
    mimestring = `file --mime -b "#{path}"`.gsub(/\n/,"")
    mimetype, encoding = /(\w+\/\w+); (.+)/.match(mimestring)[1,2]
    return mimetype, encoding
  end

end#Mimetype
end#Richfile

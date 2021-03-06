require 'rake'
require 'rake/rdoctask'

# list of files for RDoc
def src_filelist
  FileList['lib/**/*.rb'].concat ['README.rdoc']
end

desc "build the documentation"
Rake::RDocTask.new(:doc) do |rd|
  #rd.external # run the rdoc process as an external shell
  rd.main = "README.rdoc" # 'name' will be the initial page displayed
  rd.rdoc_dir = "doc" # set the output directory
  rd.rdoc_files = src_filelist
  #rd.template = "html" # Name of the template to be used by rdoc
  rd.title = "Richfile" # Title of the RDoc documentation
  #rd.options << "--accessor accessorname[,..]" # comma separated list of additional class methods that should be treated like 'attr_reader' and friends.
  rd.options << "--all" # include all methods (not just public) in the output
  #rd.options << "--charset charset" # specifies HTML character-set
  #rd.options << "--debug" # displays lots on internal stuff
  #rd.options << "--diagram" # Generate diagrams showing modules and classes using dot.
  #rd.options << "--exclude pattern" # do not process files or directories matching pattern unless they're explicitly included
  #rd.options << "--extension new=old" #  Treat files ending with .new as if they ended with .old
  #rd.options << "--fileboxes" # classes are put in boxes which represents files, where these classes reside.
  #rd.options << "--force-update" # forces to scan all sources even if newer than the flag file.
  #rd.options << "--fmt format name" # set the output formatter (html, chm, ri, xml)
  #rd.options << "--image-format gif/png/jpg/jpeg" # Sets output image format for diagrams. Default is png.
  #rd.options << "--include dir[,dir...]" #  set (or add to) the list of directories to be searched.
  rd.options << "--inline-source" # Show method source code inline, rather than via a popup link
  rd.options << "--line-numbers" # Include line numbers in the source code
  #rd.options << "--merge" # when creating ri output, merge processed classes into previously documented classes of the name name
  #rd.options << "--one-file" # put all the output into a single file
  #rd.options << "--opname name" # Set the 'name' of the output. Has no effect for HTML format.
  #rd.options << "--promiscuous" # Show module/class in the files page.
  #rd.options << "--quiet" #  don't show progress as we parse
  #rd.options << "--ri" # generate output for use by 'ri.' local
  #rd.options << "--ri-site" # generate output for use by 'ri.' sitewide
  #rd.options << "--ri-system" # generate output for use by 'ri.' system wide, for Ruby installs.
  #rd.options << "--show-hash" # A name of the form #name in a comment is a possible hyperlink to an instance method name. When displayed, the '#' is removed unless this option is specified
  #rd.options << "--style stylesheet url" # specifies the URL of a separate stylesheet.
  #rd.options << "--tab-width n" # Set the width of tab characters (default 8)
  #rd.options << "--webcvs url" # Specify a URL for linking to a web frontend to CVS.    
end

desc "build the documentation with "
Rake::RDocTask.new(:diagrams) do |rd|
  #rd.external # run the rdoc process as an external shell
  rd.main = "README.rdoc" # 'name' will be the initial page displayed
  rd.rdoc_dir = "doc" # set the output directory
  rd.rdoc_files = src_filelist
  #rd.template = "html" # Name of the template to be used by rdoc
  rd.title = "Richfile" # Title of the RDoc documentation
  #rd.options << "--accessor accessorname[,..]" # comma separated list of additional class methods that should be treated like 'attr_reader' and friends.
  rd.options << "--all" # include all methods (not just public) in the output
  #rd.options << "--charset charset" # specifies HTML character-set
  #rd.options << "--debug" # displays lots on internal stuff
  rd.options << "--diagram" # Generate diagrams showing modules and classes using dot.
  #rd.options << "--exclude pattern" # do not process files or directories matching pattern unless they're explicitly included
  #rd.options << "--extension new=old" #  Treat files ending with .new as if they ended with .old
  rd.options << "--fileboxes" # classes are put in boxes which represents files, where these classes reside.
  #rd.options << "--force-update" # forces to scan all sources even if newer than the flag file.
  #rd.options << "--fmt format name" # set the output formatter (html, chm, ri, xml)
  #rd.options << "--image-format gif/png/jpg/jpeg" # Sets output image format for diagrams. Default is png.
  #rd.options << "--include dir[,dir...]" #  set (or add to) the list of directories to be searched.
  rd.options << "--inline-source" # Show method source code inline, rather than via a popup link
  rd.options << "--line-numbers" # Include line numbers in the source code
  #rd.options << "--merge" # when creating ri output, merge processed classes into previously documented classes of the name name
  #rd.options << "--one-file" # put all the output into a single file
  #rd.options << "--opname name" # Set the 'name' of the output. Has no effect for HTML format.
  #rd.options << "--promiscuous" # Show module/class in the files page.
  #rd.options << "--quiet" #  don't show progress as we parse
  #rd.options << "--ri" # generate output for use by 'ri.' local
  #rd.options << "--ri-site" # generate output for use by 'ri.' sitewide
  #rd.options << "--ri-system" # generate output for use by 'ri.' system wide, for Ruby installs.
  #rd.options << "--show-hash" # A name of the form #name in a comment is a possible hyperlink to an instance method name. When displayed, the '#' is removed unless this option is specified
  #rd.options << "--style stylesheet url" # specifies the URL of a separate stylesheet.
  #rd.options << "--tab-width n" # Set the width of tab characters (default 8)
  #rd.options << "--webcvs url" # Specify a URL for linking to a web frontend to CVS.    
end

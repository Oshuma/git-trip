= GitTrip

Github:: http://github.com/Oshuma/git-trip/
RubyForge:: http://git-trip.rubyforge.org/

=== DESCRIPTION:

Visualize git commit SHAs.  It's nerd acid!

=== SYNOPSIS:

GitTrip is a unique, completely useless, way of visualizing git commit SHA
strings.  Since a single SHA is 40 characters (0-9, a-f), you can derive
6 RGB colors from each git object.  (40/6 == 6 with 4 characters left over)
With these 6 colors comes a wide range of possibilities.  GitTrip::Painter will
support multiple 'rendering modes' which will determine what the resulting
commit image will look like.

If you find bugs, or have suggestions, post on the RubyForge tracker and forums, respectively.

=== REQUIREMENTS:

* Grit - For reading git information from a directory.
* JSON - For reading git information from a URI.
* RMagick

=== INSTALL:

 # From Github:
 $ gem sources -a http://gems.github.com/ # (You only need to do this once.)
 $ gem install Oshuma-git-trip

=== USAGE:

See the individual class docs for more options and specific examples.

 # Load it up!
 require 'git_trip'

 # Grab repository information.
 repo = GitTrip::Gitter::Dir.new('/path/to/repo')
 # .. or ..
 repo = GitTrip::Gitter::URI.new('http://domain.com/path/to/repo')

 # Now that you have a repository, you can do cool shit.
 repo.commits.each do |commit|
   # Painter requires a commit SHA (string).
   painter = GitTrip::Painter.new(commit)

   # This does the work of creating a commit specific image.
   painter.paint!

   # Depending on the <tt>:style</tt> option passed to Painter.new,
   # +picture+ now holds either a Magick::Image or Magick::ImageList,
   # so all of their respective methods are supported.
   painter.picture.display
 end

=== LICENSE:

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004
             	   http://sam.zoy.org/wtfpl/


 Copyright (C) 2008 Dale Campbell <dale@save-state.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.

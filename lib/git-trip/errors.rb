module GitTrip

  # Holds Errors (Exceptions) specific to GitTrip.
  module Errors
    %w{
      DirNotFound
      InvalidFormat
      InvalidGitRepo
      InvalidMode
      InvalidPicture
      InvalidSHA
      InvalidStyle
      InvalidURI
      NoCommits
      RTFM
    }.each do |problem|
      eval("class #{problem} < Exception; end")
    end
  end # of Errors

end

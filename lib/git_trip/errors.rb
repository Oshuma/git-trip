module GitTrip

  # Holds Errors (Exceptions) specific to GitTrip.
  module Errors
    %w{
      CanvasTooSmall
      DirNotFound
      InvalidFormat
      InvalidGitRepo
      InvalidURI
      NoCommits
      RTFM
    }.each do |problem|
      eval("class #{problem} < Exception; end")
    end
  end # of Errors

end

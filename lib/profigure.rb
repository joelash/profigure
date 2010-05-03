require 'yaml'
require 'erb'

require 'mostash'

require File.join(File.dirname(__FILE__), "profigure", "profigure")

def dbg( msg )
  file_name = __FILE__.split( '/' ).last
  puts "#{file_name} ##{__LINE__}: #{msg}"
end

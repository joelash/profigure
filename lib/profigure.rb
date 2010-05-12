require 'yaml'
require 'erb'

require 'mostash'

require File.join(File.dirname(__FILE__), "profigure", "hash_extensions")
require File.join(File.dirname(__FILE__), "profigure", "profigure")

def dbg( msg )
  file, line, method_raw = caller[0].split('/').last.split(':')
  method = method_raw.match(/^in `(.+)'/)[1] rescue "unknown"
  puts "#{method} (#{file}##{line}): #{msg}"
end


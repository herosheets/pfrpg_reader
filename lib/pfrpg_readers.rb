module PfrpgReaders
end

require 'pfrpg_readers/defensible'

Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), 'pfrpg_readers/')) + "/**/*.rb"].each do |file|
  require file
end
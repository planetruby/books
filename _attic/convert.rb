#####################
# use like:
#   ruby _attic/convert.rb



require 'pp'
require 'json'
require 'yaml'
require 'fileutils'



bookfiles = Dir.glob( "_attic/books/**/**.json" )

##pp bookfiles
puts "   #{bookfiles.size} book(s)"


bookfiles.each_with_index do |path,i|
  extname  = File.extname( path )
  basename = File.basename( path, extname )

  text = File.open( path, 'r:utf-8') { |f| f.read }
  data = JSON.parse( text )



  year = data['year']
  if year.nil?
    puts "!! ERROR - required year missing in bookfile:"
    pp data
    exit 1
  end

  ## note: change year to a number or nil (from string)
  data['year'] =  year.size > 0 ? year.to_i : nil


  year = "0000"    if year.size == 0  ## use for missing year - why? why not?

  puts "[#{i+1}/#{bookfiles.size}]  >#{year}<  >#{basename}<  >#{extname}<"


  ## note:
  ##   hack for now use jekyll collection  (only .html and .md document supported)
  ##    use .md document with .yml front matter
  outpath = "_books/#{year}/#{basename.gsub(' ', '_')}.md"
  puts "  => #{outpath}"

  FileUtils.mkdir_p( File.dirname( outpath ) ) ## make sure path exits

  File.open( outpath, 'w:utf-8') do |f|
    f.write( data.to_yaml )
    f.write( "---" )
    f.write( "\n" )
  end
end


puts "done"
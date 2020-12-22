#!/usr/bin/env ruby

require "erb"
require 'json'

`rm -rf /tmp/ruby-books`
`git clone https://github.com/Florent2/ruby-books /tmp/ruby-books`

books = []
Dir.glob('/tmp/ruby-books/books/*.json') do |book_file|
  books << JSON.parse(File.read book_file)
  Dir.chdir "/tmp/ruby-books"
  books.last["updated_on"] = `git log -1 --format=%ci "#{book_file}"`.split(" ").first
end

Dir.chdir "/Users/Florent/code/books-ui/"

books.sort_by! { |book| book["year"].to_i }.reverse!

authors    = books.map { |book| book["authors"] }.flatten.sort.uniq
categories = books.map { |book| book["categories"] }.flatten.sort_by(&:downcase).uniq
editors    = books.map { |book| book["editor"] }.sort_by(&:downcase).uniq

renderer = ERB.new File.read("index.html.erb")
File.write "index.html", renderer.result

# Notes


**Update 2021** - Work-in-progess - getting converted over to the new home here at Planet Ruby.

For now the current plan is to use this collection and merge in the [`/books-old`](https://github.com/planetruby/books-old) repo
and convert all book datafiles to YAML with directories by publication year (e.g. `/2019`, `/2020`, `/2021` etc.).




On filenames:

- do NOT use `:` in filenames e.g. `Beginning Ruby: From Novice to Professional.json` will break checkouts on Windows; use `-` instead or such
- do NOT use `?` in filenames e.g. `What do I test?.json` will break checkouts on Windows; remove for now - why? why not?


On book data:

- use 0000/ directory for now for books with missing/empty publication year - why? why not?
- change `url` to `home_url` - why?  `url` is predefined in collections and is the url of the collection page itself!!!!!



old build script:

- [ ] how to get last update back (without git) - possible?

``` ruby
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
```
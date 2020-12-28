# All Ruby Books

This is the JSON backend of the All Ruby Books website / page.

The book collection was started by [Florent Guilleux](https://github.com/Florent2) in 2016.  Thanks! Merci!


Contributions welcome! Just send pull requests.


Formerly @ [`www.allrubybooks.com`](http://www.allrubybooks.com/)



**Update 2021** - Work-in-progess - getting converted over to the new home here at Planet Ruby.

For now the current plan is to use this collection and merge in the [`/books-old`](https://github.com/planetruby/books-old) repo
and convert all book datafiles to YAML with directories by publication year (e.g. `/2019`, `/2020`, `/2021` etc.).



## Notes

On filenames:

- do NOT use `:` in filenames e.g. `Beginning Ruby: From Novice to Professional.json` will break checkouts on Windows; use `-` instead or such
- do NOT use `?` in filenames e.g. `What do I test?.json` will break checkouts on Windows; remove for now - why? why not?


On book data:

- use YYYY/ directory for now for books with missing/empty publication year - why? why not?


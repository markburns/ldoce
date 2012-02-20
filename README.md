Easily interface with the Longman Dictionary of Contemporary English API from Ruby:

```ruby
cat = Word.search 'cat'
cat.play #plays mp3 sample - only working for Mac at the moment
cat.definition
#=> "A small four legged animal commonly kept as a pet"
```

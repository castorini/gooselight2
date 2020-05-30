# README
To begin, ensure that you have Ruby 2.6.5+ and Ruby on Rails 5.0+ installed. Note, geoblacklight does not yet support rails 6.0

Once you are inside the `geoblacklight-waterloo` directory, execute:
```bash
bundle install
```
After the dependencies are installed, execute:
```bash
rails db:migrate
rake geoblacklight:server
```
Then geoblacklight should be avaliable on http://localhost:3000/.

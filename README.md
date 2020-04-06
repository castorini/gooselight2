# Gooselight 2

![gooselight](https://seeklogo.com/images/D/Duck_Hunt-logo-8044A0A3B6-seeklogo.com.png)

This project contains multiple [Project Blacklight](http://projectblacklight.org/) application for Solr indexes built by [Anserini](https://github.com/castorini/Anserini).

## Requirements

* [Java](https://www.java.com/en/download/) 8+
* [Ruby](https://www.ruby-lang.org/en/) 2.6.5
  * Using the [Ruby Version Manager (RVM)](https://rvm.io/) is recommended
* [Anserini](https://github.com/castorini/anserini)
* [Solr](https://archive.apache.org/dist/lucene/solr/) version matching the Anserini Lucene version
    * Version 8.3.0 as of Anserini commit [eff7755](https://github.com/castorini/anserini/commit/eff7755a611bd20ee1d63ac0167f5c8f38cd3074)

## Getting Started

### Prerequisites
* Running each individual Blacklight app requires building the matching Solr collection
  * ie) `hydrology`, `gwf`, `acl`
* Follow the [Solrini](https://github.com/castorini/anserini/blob/master/docs/solrini.md) instructions to build the appropriate collection

### Development
* Navigate to one of the Rails apps in the subdirectories
* Install dependencies
  * `bundle install`
* Create db migrations
  * `rails db:migrate`
* Start the Rails server
  * `rails s`
* http://localhost:3000

### Production

* Install dependencies
  * `bundle install`

* Precompile assets and migrate database
  * `RAILS_ENV=production bundle exec rake assets:precompile`
  * `RAILS_ENV=production rails db:migrate`

* Run the Rails server in production mode with static files
  * `RAILS_ENV=production RAILS_SERVE_STATIC_FILES=true rails s`

## License

This application is available as open source under the terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

# json-search
Example of how to efficiently load and query a JSON document

## Description
This project provides a demonstration of how to load a JSON document into an SQLite database, for the purpose of performing various queries.

## Setup
First step to use this code is to check it out:

`git clone git@github.com:simonhildebrandt/json-search.git`

This code has been tested with Ruby 3.3.5 - so the next step is to install a suitable version of Ruby using your method of choice. I recommend [asdf](https://asdf-vm.com/) - a `.tool-versions` file suitable for that has been provided.

Finally, run `bundle` to install the only external dependency - [SQLite](https://github.com/sparklemotion/sqlite3-ruby).

## Usage

This code works in three modes: there's a shell script in the project root that trigger the desired behaviour, once it's made executable:
```
chmod a+x json-search-cli
./json-search-cli name_search Al
```

Or the code can be loaded directly:
```
irb -Ilib -rjson-search
> JsonSearch.duplicate_emails
```


Alternately, installing the gem and use it directly, included in larger projects or in an Ruby REPL.
```
gem build json-search.gemspec
gem install json-search-0.0.1.gem
```

## Options

The executable version provides two sub-commands - `name_search` and `duplicate_emails`; the latter will list duplicates found in the client file, the form takes a name fragment and searches in the data for matches.

## Testing

Calling `bundle` locally will also install Rspec as a dev dependency - then run `rspec` to run the test suite.

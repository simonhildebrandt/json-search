require 'json-search'

class JsonSearchCli
  def self.run
    case ARGV[0]
      when 'name_search'
        name = ARGV[1] || error("Provide a name fragment to search for")
        puts JsonSearch.name_search(name)
      when 'duplicate_emails'
        duplicates = JsonSearch.duplicate_emails
        puts duplicates.length > 0 ? duplicates : "No duplicates found"
      else
        error("please choose 'name-search' or 'duplicate-emails' mode")
    end
  end

  def self.error(message)
    puts message
    exit(1)
  end
end


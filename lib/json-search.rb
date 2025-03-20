require 'json-client-db'

class JsonSearch
  def self.name_search(name)
    with_db do |db|
      db.execute("select * from clients where full_name LIKE ?", "%#{name}%")
    end
  end

  def self.duplicate_emails
    with_db do |db|
      emails = db.execute("select email from clients group by email having count(*) > 1")
      # Awkward SQL string munging 'cause SQLite doesn't support array placeholders like Rails
      email_clause = emails.flatten.map { "'#{_1}'" }.join(',')
      db.execute("select id, full_name, email from clients where email in (#{email_clause})")
    end
  end

  def self.with_db(&)
    JsonClientDb.new('examples/clients.json').with_db(&)
  end
end

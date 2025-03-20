require 'sqlite3'
require 'tempfile'
require 'json'

class JsonClientDb
  class BaseError < StandardError; end
  class InvalidFileError < BaseError; end
  class MissingFileError < BaseError; end

  def initialize(path)
    @path = path
  end

  def with_db &block
    with_database do |db|
      db.execute(<<~SQL
        create table clients (
          #{sql_fields}
        )
        SQL
      )
      load_records(db)

      yield db
    end
  end

  def attributes
    attribute_mapping.keys
  end

  private

  def attribute_mapping
    {
      'id' => 'integer',
      'full_name' => 'text',
      'email' => 'text'
    }
  end

  def sql_fields
    attribute_mapping.map{|k, v| "#{k} #{v}"}.join(",\n")
  end

  def with_database &block
    Tempfile.open('database.db') do |file|
      yield SQLite3::Database.new(file)
    end
  end

  def load_records(db)
    file_records.each do |r|
      fields = r.values_at(*attributes)
      db.execute("insert into clients (#{attributes.join(',')}) values (?, ?, ?)", fields)
    end
  end

  def file_records
    @file_records ||= JSON.parse(file_contents)
  rescue Errno::ENOENT
    raise MissingFileError, "Couldn't find file #{@path}"
  rescue JSON::ParserError => ex
    raise InvalidFileError, "Couldn't parse file #{@path}"
  end

  def file_contents
    File.read(@path)
  end
end


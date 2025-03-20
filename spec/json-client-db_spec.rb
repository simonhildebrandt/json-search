require 'spec_helper'

describe JsonClientDb do
  let(:path) { 'examples/clients.json' }
  let(:query) do
    described_class.new(path).with_db do |db|
      db.execute("select * from clients")
    end
  end

  it "loads for a valid file" do
    expect { query }.not_to raise_error
  end

  context "for an missing file" do
    let(:path) { 'missing.json' }
    it "raises an appropriate error" do
      expect { query }.to raise_error(JsonClientDb::MissingFileError)
    end
  end

  context "for an invalid file" do
    let(:path) { 'examples/broken.json' }
    it "raises an appropriate error" do
      expect { query }.to raise_error(JsonClientDb::InvalidFileError)
    end
  end
end

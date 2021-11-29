require "./spec_helper"

include Comandante

describe Comandante::Helper do
  it "writer/reader should work" do
    str = "test"
    Cleaner.tempfile do |file|
      Helper.write_zstd(str, file)
      x = Helper.read_zstd(file)
      x.should eq(str)
    end
  end

  it "writer/reader should work" do
    str = "test"
    Cleaner.tempfile do |file|
      Helper.write_zstd(file) do |io|
        io.print "test1"
        io.print "test2"
      end
      x = Helper.read_zstd(file)
      x.should eq("test1test2")
    end
  end

  it "writer/reader in a block should work" do
    strs = ["test1", "test2"]
    results = Array(String).new
    Cleaner.tempfile do |file|
      Helper.write_zstd(strs.join("\n"), file)
      Helper.read_zstd(file) do |x|
        results << x
      end
      results.should eq(strs)
    end
  end
end

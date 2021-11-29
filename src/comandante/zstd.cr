require "comandante"
require "zstd"

# TODO: think a custom exception

module Comandante
  module Helper
    # Reads zstd file into a string
    def self.write_zstd(obj, path, level = 3) : Nil
      File.open(path, "w") do |io|
        cctx = Zstd::Compress::Context.new(level: level)
        if obj.responds_to? :to_slice
          cbuf = cctx.compress obj.to_slice
        else
          raise "to slice not implemented for io type: #{typeof(io)}"
        end

        io.write cbuf
      end
    end

    # Reads zstd file line by line
    def self.write_zstd(path, level = 3, &block) : Nil
      File.open(path, "w") do |io|
        Zstd::Compress::IO.open(io, level: level) do |cio|
          yield cio
        end
      end
    end

    # Reads zstd file into a string
    def self.read_zstd(path)
      str = ""
      Helper.assert_file(path)
      File.open(path) do |io|
        str = Zstd::Decompress::IO.open(io) do |dio|
          dio.gets_to_end
        end
      end
      return str
    end

    # Reads zstd line by line
    #
    # ```
    # read_zstd(path) { |line| puts line }
    # ```
    def self.read_zstd(path, &block) : Nil
      Helper.assert_file(path)
      File.open(path) do |io|
        Zstd::Decompress::IO.open(io) do |dio|
          line = dio.gets
          while !line.nil?
            yield line
            line = dio.gets
          end
        end
      end
    end
  end
end

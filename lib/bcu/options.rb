require "optparse"
require "ostruct"

module Bcu
  class << self; attr_accessor :options; end

  def self.parse!(args)
    options = OpenStruct.new
    options.all = false
    options.cask = nil
    options.dry_run = true

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: brew cu [options]"

      opts.on("-a", "--all", "Force upgrade outdated apps including the ones marked as latest") do
        options.all = true
      end

      opts.on("-y", "--yes", "Update all outdated apps; answer yes to updating packages") do
        options.dry_run = false
      end

      opts.on("--cask [CASK]", "Specify a single cask for upgrade") do |name|
        options.cask = name
      end

      # `-h` is not available since the Homebrew hijacks it.
      opts.on_tail("--h", "Show this message") do
        puts opts
        exit
      end
    end

    parser.parse!(args)
    self.options = options
  end
end
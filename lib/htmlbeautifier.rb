require "htmlbeautifier/builder"
require "htmlbeautifier/html_parser"
require "htmlbeautifier/version"

module HtmlBeautifier
  #
  # Returns a beautified HTML/HTML+ERB document as a String.
  # html must be an object that responds to +#to_s+.
  #
  # Available options are:
  # tab_stops - an integer for the number of spaces to indent, default 2.
  # Deprecated: see indent.
  # indent - what to indent with ("  ", "\t" etc.), default "  "
  # stop_on_errors - raise an exception on a badly-formed document. Default
  # is false, i.e. continue to process the rest of the document.
  # initial_level - The entire output will be indented by this number of steps.
  # Default is 0.
  # preserve_empty_lines - an integer for the number of empty lines to allow
  # in a row.
  #
  def self.beautify(html, options = {})
    if options[:tab_stops]
      options[:indent] = " " * options[:tab_stops]
    end
    "".tap { |output|
      HtmlParser.new.scan html.to_s, Builder.new(output, options)
    }
  end
end

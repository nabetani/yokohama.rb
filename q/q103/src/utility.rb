# frozen_string_literal: true

require "rouge"

def ruby_src(fn0)
  fn = File.join(File.split(__FILE__)[0], fn0)
  src = File.open(fn, &:read).gsub("\n", "\r\n")
  formatter = Rouge::Formatters::HTML.new
  lexer = Rouge::Lexers::Ruby.new
  html = formatter.format(lexer.lex(src))
end

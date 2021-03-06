module Treetop
  module Compiler
    class GrammarCompiler
      def compile(source_path, target_path = source_path.gsub(/\.(treetop|tt)\Z/, '.rb'))
        File.open(target_path, 'w') do |target_file|
          target_file.write(ruby_source(source_path))
        end
      end

      # compile a treetop file into ruby
      def ruby_source(source_path)
        ruby_source_from_string(File.read(source_path))
      end

      # compile a string containing treetop source into ruby
      def ruby_source_from_string(s)
        parser = MetagrammarParser.new
        result = parser.parse(s)
        unless result
          raise RuntimeError.new(parser.failure_reason)
        end
        result.compile
      end
    end
  end

  # compile a treetop source file and load it
  def self.load(path)
    adjusted_path = path =~ /\.(treetop|tt)\Z/ ? path : path + '.treetop'
    File.open(adjusted_path) do |source_file|
      load_from_string(source_file.read)
    end
  end

  # compile a treetop source string and load it
  def self.load_from_string(s)
    compiler = Treetop::Compiler::GrammarCompiler.new
    Object.class_eval(compiler.ruby_source_from_string(s))
  end
end

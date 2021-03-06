module Cucumber
  class StepMatch
    attr_reader :step_definition
    attr_reader :args
    
    def initialize(step_definition, step_name, formatted_step_name, args)
      @step_definition, @step_name, @formatted_step_name, @args = step_definition, step_name, formatted_step_name, args
    end
    
    def invoke(world, multiline_arg)
      all_args = @args.dup
      all_args << multiline_arg if multiline_arg
      @step_definition.invoke(world, all_args, @step_name)
    end

    def format_args(format)
      @formatted_step_name || @step_definition.format_args(@step_name, format)
    end
    
    def file_colon_line
      @step_definition.file_colon_line
    end

    def backtrace_line
      @step_definition.backtrace_line
    end
  end
  
  class NoStepMatch
    attr_reader :step_definition

    def initialize(step)
      @step = step
    end
    
    def format_args(format)
      @step.name
    end

    def file_colon_line
      raise "No file:line for #{@step}" unless @step.file_colon_line
      @step.file_colon_line
    end

    def backtrace_line
      @step.backtrace_line
    end
  end
end
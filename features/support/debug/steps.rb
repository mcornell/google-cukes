require 'cucumber/formatter/io'
require 'cucumber/runtime'
require 'cucumber/formatter/pretty'

$SUB_STEPS = []
$ALL_STEPS = []

module Debug
  # The formatter used for <tt>--format Debug::Steps</tt>
  class Steps < Cucumber::Formatter::Pretty
    include Cucumber::Formatter::Io

    alias __original_step_name__ step_name

    def after_feature_element(feature_element)
      @io.puts "----"
      @io.puts "All Steps run for: #{feature_element.name}"
      @io.puts
      $ALL_STEPS.each { |a_step| @io.puts(a_step.indent(@indent)) }
      $ALL_STEPS.clear
      @io.puts "----"
      @io.flush
    end

    def after_step(step)
      $SUB_STEPS.delete_at 0
      $SUB_STEPS.each { |a_step| @io.puts(a_step.indent(@indent)) }
      $SUB_STEPS.clear
    end

  end
end

module Cucumber
  class StepMatch #:nodoc:
    alias __original_initialize__ initialize

    # Creates a new StepMatch. The +name_to_report+ argument is what's reported, unless it's is,
    # in which case +name_to_report+ is used instead.
    #
    def initialize(step_definition, name_to_match, name_to_report, step_arguments)
      $ALL_STEPS << name_to_match
      $SUB_STEPS << name_to_match
      __original_initialize__(step_definition, name_to_match, name_to_report, step_arguments)
    end
  end
end

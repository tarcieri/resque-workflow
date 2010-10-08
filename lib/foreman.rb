require 'active_record'
require 'workflow'

module Foreman
  include ::Workflow

  module ClassMethods
    # Set the default state of this workflow
    # Explicitly specify the states of the workflow
    def states(*states)
      if states.last.is_a? Hash
        options = states.pop
      else
        options = {}
      end
      
      @__valid_states  = states.map { |state| state.to_sym }
      @__default_state = options[:default].to_sym || @__valid_states.first
      
      unless valid_states.include? default_state
        raise ArgumentError, "default state '#{@__default_state}' is invalid"
      end
      
      validates_inclusion_of :state, :in => valid_states
    end
  
    # Declare a workflow
    def workflow
      yield
    end
  
    # Specify a job for a given state
    def job_for(state, options = {}) 
    end
    
    # Return the list of valid sates    
    def valid_states; @__valid_states; end
    
    # Return the default state
    def default_state; @__default_state; end
  end
  
  def self.included(klass)
    klass.send :extend, ClassMethods
  end
end
require 'active_record'
require 'workflow'

module Foreman
  include ::Workflow

  module ClassMethods
    # Set the default state of this workflow
    def default_state(state)
      @__default_state = state.to_sym
    end
  
    # Explicitly specify the states of the workflow
    def valid_states(*states)
      @__valid_states = states.map { |state| state.to_sym }
      validates_inclusion_of :state, :in => @__valid_states
    end
  
    # Declare a workflow
    def workflow
      yield
    end
  
    # Specify a job for a given state
    def job_for(state, options = {}) 
    end
  end
  
  def self.included(klass)
    klass.send :extend, ClassMethods
  end
end
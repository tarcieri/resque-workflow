gem 'activerecord', '3.0.0.rc'
gem 'workflow'
gem 'resque'

require 'active_record'
require 'workflow'

module Foreman
  class Base < ActiveRecord::Base
    include Workflow
    
    class << self
      def default_state(state)
        @__default_state = state.to_sym
      end
      
      def valid_states(*states)
        @__valid_states = states.map { |state| state.to_sym }
        validates_inclusion_of :state, :in => @__valid_states
      end
      
      def job_for(state, options = {}) 
      end
    end
  end
end
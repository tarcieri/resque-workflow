Resque::Workflow
=======

A DSL for describing worflows whose steps are Resque jobs

Philosophy
----------

Workflows are finite state machines, described as a set of states whose
transitions are jobs.  Jobs can either succeed or fail, and workflows
must account for either case when transitioning between states.

Job failures fall into one of three categories:

* Temporary failure: Something went wrong which might magically fix itself at
  some point in the future.  The job should be retried a certain number of
  times until it succeeds, or until it's failed so much we just give up.
  
* Error: An exception occurred in the system.  The problem should be remedied
  and the job retried once it's been fixed.
  
* Permanent failure: The job is completely hosed and there's no way to fix it.

Workflows, as part of their design, will automatically retry jobs unless they
permanently fail.  This means that all jobs must be *idempotent*: if they are
run multiple times by mistake, they will not cause adverse effects on the
system such as unexpected duplicated objects.  Instead, if the job is run
multiple times the system should always end in a clean, expected state.

Foreman cannot ensure your jobs are idempotent.  Ensuring they are is left as
an exercise to the user.

Example Workflow
----------------

  class Cat < ActiveRecord::Base
    include Resque::Workflow
  
    states :new, :caught, :in_bathroom, :washed, :default => :new 
    workflow do
      # Catch the cat
      job_for :new, :success => :caught do |cat|
        puts "Catching the cat..."
        cat.grab      
      end
  
      # Walk to bathroom
      job_for :caught, :success => :in_bathroom, :fail => :new do |cat|
        puts "Carrying cat to the bathroom"
        cat.carry_to_bathroom
      end
    
      # Wash cat
      job_for :in_bathroom, :success => :washed do |cat|
        puts "Washing cat"
        cat.wash
      end
    end
  
    def grab  
      puts "Cat caught!"
    end
  
    def carry_to_bathroom
      puts "Cat carried to bathroom!"
    end
  
    def wash
      puts "Cat washed!"
    end
  end

Status
------

A basic example of the DSL I have in mind is available in spec/base_spec.rb.
However, this DSL is very much unimplemented at this point.

Copyright
---------

Copyright (c) 2010 Tony Arcieri. See LICENSE for details.

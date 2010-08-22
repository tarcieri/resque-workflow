Foreman
=======

Foreman brings together two fantastically powerful gems to give you the
greatest workflow manager ever:

* workflow: Manages the persistent state of workflows using ActiveRecord 
* resque: Distributes jobs, the subcomponents of workflows, to workers

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

    class CatWashWorkflow < Foreman::Base
      valid_states  :new, :cat_caught, :in_bathroom
      default_state :new
  
      workflow do
        # Catch the cat
        job_for :new, :success => :cat_caught do
          puts "Catching the cat..."
          # come_here_kitty.no_dont_run_away.gaaaah.got_you.owwwww_stop_it
          puts "Cat caught!"
        end
  
        # Walk to bathroom
        job_for :cat_caught, :success => :in_bathroom, :fail => :new do
          puts "Walking to the bathroom..."
          # dont_jump_out_of_my_hands_you_little_bugger
          unless @never_works_the_first_time
            @never_works_the_first_time = true
      
            msg = "Uhoh, she sensed I was gonna bathe her and got away"
            puts msg
            raise msg
          end
          puts "Yay at least got to the bathroom"
        end
      end
    end

Status
------

A basic example of the DSL I have in mind is available in spec/base_spec.rb.
However, this DSL is very much unimplemented at this point.

Copyright
---------

Copyright (c) 2010 Tony Arcieri. See LICENSE for details.

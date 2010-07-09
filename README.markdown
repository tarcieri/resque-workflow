Foreman
=======

Foreman brings together three fantastically powerful gems to give you the
greatest workflow manager ever:

* workflow: Manages the persistent state of workflows using ActiveRecord 
* resque: Distributes jobs, the subcomponents of workflows, to workers
* tap: Provides a DSL for authoring the steps of various jobs

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

Status
------

This project is total vapor! Dreams made of starstuff, if you will!

Copyright
---------

Copyright (c) 2010 Tony Arcieri. See LICENSE for details.

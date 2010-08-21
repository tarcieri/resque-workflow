require File.expand_path('../spec_helper', __FILE__)

class CatWashWorkflow < Foreman::Base
  valid_states  :new, :cat_caught, :in_bathroom
  default_state :new
  
  # Catch the cat
  job_for :new, :success => :cat_caught, :fail => :catch_cat do
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

describe Foreman::Base do
  it "executes workflows" do
    cat_wash = CatWashWorkflow.new
    cat_wash.run
    cat_wash.in_bathroom?.should be_true
  end
end

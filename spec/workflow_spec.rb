require File.expand_path('../spec_helper', __FILE__)

class Cat< ActiveRecord::Base
  include Foreman
  
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

describe Foreman do
  it "executes workflows" do
    cat = Cat.new
    cat.run_workflow
    cat.washed?.should be_true
  end
end

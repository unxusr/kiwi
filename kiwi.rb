#!/usr/bin/ruby

require 'colorize'
require 'fileutils'
require_relative 'ksupport.rb'

class Kiwi

  def feature(feature, scenario)
    @feature = feature
    @scenario = scenario
  end

  def create_feature
    print "Feature name: ".magenta
    @feature = gets.chomp
    print "Scenario: ".magenta
    @scenario = gets.chomp
    puts "please enter steps:".red
    puts "Cucumber steps starts with 'Given, When, Then, And, But' keywords.".red
  end

  def steps
    steps_keywords = %w(Given When Then And But)
    nsteps = 0
    @steps = []
    while true
      print "Add step [Y/N]: ".light_black
      choice = gets
      if choice.downcase.strip == "y"
        puts "step #{nsteps +1}:"
        step = gets.capitalize
        init_step_word = step.split(' ').first
      if steps_keywords.include?(init_step_word)
        @steps << step
        nsteps = nsteps ++ 1
      else
        puts "Error: #{init_step_word} unsupported initial value"
        puts "Use only #{steps_keywords} keywords"
      end
      elsif choice.downcase.strip == "n"
        break
      else
        "please enter a valid choice."
      end
    end
  end

  def mk_struct
    fdir =  `mkdir #{@feature}`
    File.open("#{@feature}/""#{@feature}.feature", "w") do |f|
      f.write("Feature: #{@feature}\n")
      f.write("\tScenario: #{@scenario}\n")
    end
   @steps.each do |steps|
   File.open("#{@feature}/""#{@feature}.feature", "a") do |f|
     f.write("\t\t#{steps}")
     end
   end
   FileUtils.mkdir "#{@feature}/step_definitions"
   FileUtils.mkdir "#{@feature}/support"
   FileUtils.touch "#{@feature}/support/env.rb"
   FileUtils.touch "#{@feature}/step_definitions/#{@feature}_steps.rb"
  end
   
  def cucumber_wrapper
   cucumber = `cucumber #{@feature}/#{@feature}.feature`
   File.open("#{@feature}/step_definitions/#{@feature}_steps.rb", 'w') do |parsed_steps|
     parsed_steps.write cucumber.split("You can implement step definitions for undefined steps with these snippets:\n\n").last
   end
  end
end
kiwi = Kiwi.new
kiwi.create_feature
kiwi.steps
kiwi.mk_struct
kiwi.cucumber_wrapper
